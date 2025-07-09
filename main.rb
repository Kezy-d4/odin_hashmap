require_relative "lib/hashmap"

test = HashMap.new
# Setting
test.set("apple", "red")
test.set("banana", "yellow")
test.set("carrot", "orange")
test.set("dog", "brown")
test.set("elephant", "gray")
test.set("frog", "green")
test.set("grape", "purple")
test.set("hat", "black")
test.set("ice cream", "white")
test.set("jacket", "blue")
test.set("kite", "pink")
test.set("lion", "golden")
# Overwriting
test.set("frog", "blue")
test.set("lion", "orange")
test.set("apple", "black")
# Triggering expansion
test.set("moon", "silver")
# Overwriting
test.set("moon", "orange")
test.set("frog", "green")
test.set("dog", "black")
test.set("apple", "red")
test.set("kite", "magenta")
# Setting
test.set("plane", "white")
test.set("camel", "brown")
test.set("lake", "blue")
# Testing methods
p "get non-existent 'adam': #{test.get('adam')}"
p "get existing 'carrot': #{test.get('carrot')}"
p "has? non-existent 'gordon': #{test.get('gordon')}"
p "has? existing 'moon': #{test.has?('moon')}"
p "remove non-existent 'mike': #{test.remove('mike')}"
p "remove existing 'apple': #{test.remove('apple')}"
p "length: #{test.length}"
# test.clear
puts "keys: #{test.keys}"
puts "values: #{test.values}"
puts "pairs: #{test.pairs}"
puts test
