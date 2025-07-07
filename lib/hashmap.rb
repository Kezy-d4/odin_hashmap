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
    @buckets = Array.new(capacity) { LinkedList.new }
  end

  private

  def hash(key)
    hash_code = 0
    prime_number = 31
    key.each_char { |char| hash_code = (prime_number * hash_code) + char.ord }
    hash_code
  end

  def double_capacity
    capacity.times { buckets << LinkedList.new }
    self.capacity = buckets.length
  end
end
