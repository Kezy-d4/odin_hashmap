require_relative "linked_list"

# A blueprint for instantiating a new hashmap. When a key hashes to a certain
# bucket index, it and its value will be prepended to the linked list contained
# there in the form of a node containing a two-index array.
class HashMap
  attr_accessor :capacity, :buckets
  attr_reader :load_factor

  def initialize
    @capacity = 16
    @load_factor = 0.75
    @buckets = Array.new(capacity, LinkedList.new)
  end
end
