class Dashing.Pie extends Dashing.Widget

  ready: ->
    pie = $(@node).find(".pie")
    @render_pie pie.attr('values')




  onData: (data) ->
    @render_pie(data.values)

  
  
  
  render_pie: (data) ->
    if(!data)
      data = @get("values")
    if(!data)
      return

    data = JSON.parse(data);
    number_legend_rows = Math.ceil(data.length / 2)

    font_size = parseInt($(@node).css('font-size'))
    label_padding = 4
    width = $(@node).width()
    height = $(@node).height() * .7 - ((font_size + label_padding) * number_legend_rows)
    radius = (if width < height then width else height) / 2
    arc_width = radius / 2
    # This is supposed to auto-generate colors, but it doesn't. 
    #colors = d3.scale.category20()
    colors = ["#9c4274", "#47bbb3", "#dc5945", "#ff9618", "#208ac9"]
    threshold = 10
    total = 0
    for value_item in data
      total += parseInt(value_item.value, 10)
    

    $(@node).children("g").remove();
    
    node = d3.select(@node).append("g")
      .attr("class", "chart_area")
    
    chart = node.append("svg:svg")
        .data([data])
        .attr("width", width)
        .attr("height", height)
      .append("svg:g")
        .attr("transform", "translate(#{width / 2} , #{height / 2})")      


    #
    # Center label
    #
    label_group = chart.append("g")

    center_label = label_group.append("text")
      .attr("class", "chart_label")
      .attr("fill", "#ffffff")
      .attr("y", 15 / 200 * height)
      .attr("text-anchor", "middle")
      .text(total)
    
    
    
    #
    # The chart
    #
    arc = d3.svg.arc().innerRadius(radius - arc_width).outerRadius(radius)
    pie = d3.layout.pie().value((d) -> d.value)

    arcs = chart.selectAll("g.slice")
      .data(pie)
      .enter()
      .append("svg:g")
      .attr("class", "slice")

    arcs.append("svg:path")
      .attr("fill", (d, i) -> colors[i])
      .attr("d", arc)



    #
    # Puts values of each segment on the pie chart
    #
    arcs.append("svg:text").attr("transform", (d, i) -> 
      percent_val = Math.round(data[i].value / total * 100)
      d.innerRadius = (radius * (100 - percent_val) / 100) - 45      #45 = max text size / 2
      d.outerRadius = radius
      "translate(" + arc.centroid(d) + ")")
      .attr('fill', "#fff")
      .attr("text-anchor", "middle")
      # only displays text over segments who make up more than 10% of the chart
      .text((d,i) -> if Math.round(data[i].value / total * 100) > threshold  then Math.round(data[i].value) else null )
      .attr("x", 2)
      .attr("y", 1)
        
      
    
    #
    # Legend
    #
    legend_width = 220
    label_width = 90
    label_height = (font_size + font_size / 3) * 2
    square_size = font_size - 2
    label_padding = 10
    square_padding = 5
    row = 0
    legend = node.append("svg:svg")
      .attr("class", "legend")
      .attr("x", 0)
      .attr("y", 0)
      .attr("height", (label_height - font_size / 2) * Math.ceil(data.length / 2))
      .attr("width", legend_width)
    
    legend.selectAll("g").data(data)
      .enter()
      .append("g")
      .each((d, i) ->
        g = d3.select(this)

        col = i % 2

        g.append("rect")
          .attr("x", col * (square_size + label_width + square_padding + label_padding))
          .attr("y", row * label_height / 2)
          .attr("width", square_size)
          .attr("height", square_size)
          .attr("fill", colors[i])

        g.append("text")
          .attr("x", (col * (square_size + label_width + square_padding + label_padding)) + square_size + square_padding)
          .attr("y", (row + 1) * label_height / 2 - 6)
          .attr("font-size", font_size + "px")
          .attr("height", label_height)
          .attr("width", label_width)
          .attr("fill", "#ffffff")
          .text(data[i].label)
        
        if i % 2 == 1
          ++row
      )
