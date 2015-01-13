---
title: Amazing Pie
description: A pie chart widget for dashing, with a legend
author: Michael Woffendin
tags: dashing, widget, chart, legend, pie, amazing
created:  2015 Jan 12
modified: 2015 Jan 12

---

Amazing Pie
=========

![alt tag](https://raw.github.com/osu-sig/Amazing-Pie-Widget/master/screenshot.png)

## What is it?

Are you disappointed with Dashing's existing pie chart widgets? Then feast your eyes on the above screenshot and behold! The Pie chart widget to end all widgets!!

It's a pie chart with a legend. The center of the chart displays the total of all segments.
It works well with up to 4 segments; any more and things get weird. 

## How does it work?

See the demo files for examples. Just give it a json array of objects with labels and values. 

## Are there any dependencies?

Just Dashing!

## Does it come with any options?

Not yet.

## Your color palette sucks!

Ouch. If you don't like it, you can manually swap in your own by editing the coffeescript file on line 33.

## There's no value on one of my segments! Your widget is broken!

YOUR FACE is broken. It only displays values on segments whose area is >10% of the chart's total area. This is to stop a bunch of numbers getting smushed together. 
