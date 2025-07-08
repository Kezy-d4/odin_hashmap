require_relative "linked_list"

# A blueprint for instantiating a new hashmap. When a key hashes to a certain
# bucket index, it and its value will be prepended to the linked list contained
# there in the form of a node containing a two-index array.
class HashMap
  private

  attr_accessor :capacity, :buckets
  attr_reader :load_factor

  public

  def initialize
    @capacity = 16
    @load_factor = 0.75
    @buckets = Array.new(capacity) { LinkedList.new }
  end

  def set(key, value)
    bucket_index = hash(key) % (capacity - 1)
    if buckets[bucket_index].contains_key?(key)
      buckets[bucket_index].overwrite_value_of_existing_key(key, value)
    else
      buckets[bucket_index].prepend([key, value])
    end
    # TODO: logic to grow the hashmap if it has become overloaded according to
    # the load factor. We need a method to determine how many keys exist in the
    # hashmap to accomplish this.
  end

  def get(key)
    buckets.each do |bucket|
      value = bucket.find(key)
      return value if value
    end
    nil
  end

  def to_s
    puts "Current capacity: #{capacity}"
    puts "Load factor: #{load_factor}"
    puts "Current key limit: #{key_limit}"
    puts "Buckets:"
    buckets.each { |bucket| puts bucket }
  end

  private

  def hash(key)
    hash_code = 0
    prime_number = 31
    key.each_char { |char| hash_code = (prime_number * hash_code) + char.ord }
    hash_code
  end

  def key_limit
    (capacity * load_factor).ceil
  end

  def double_capacity
    capacity.times { buckets << LinkedList.new }
    self.capacity = buckets.length
  end
end
