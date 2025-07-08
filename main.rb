require_relative "lib/hashmap"

h = HashMap.new
h.set("Carlos", "Jacobs")
h.set("Amanda", "Winthrop")
h.set("Carlos", "Adams")
h.set("Amanda", "Rose")
p h.get("Carlos")
p h.get("Amanda")
p h.get("Josh")
p h.has?("Amanda")
p h.has?("Josh")
puts h
