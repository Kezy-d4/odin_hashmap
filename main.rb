require_relative "lib/hashmap"

h = HashMap.new
h.set("Carlos", "Jacobs")
h.set("Amanda", "Winthrop")
h.set("Carlos", "Adams")
h.set("Amanda", "Rose")
h.set("Josh", "Adams")
h.set("Gordon", "Doyle")
h.remove("Gordon")
puts h
