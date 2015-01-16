values = [
  { label: 'Value 1', value: 57 },
  { label: 'Value 2', value: 26 }
]

send_event("demo_1", values: values.to_json)



values = [
  { label: 'Value 1', value: 1 }, # This segment will not have a number over it.
  { label: 'Value 2', value: 2 },
  { label: 'Value 3', value: 3 },
  { label: 'Value 4', value: 4 }
]

send_event("demo_2", values: values.to_json)