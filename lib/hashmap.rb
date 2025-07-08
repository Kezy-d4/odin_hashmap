require_relative "bucket"

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
    @buckets = Array.new(capacity) { Bucket.new }
  end

  def set(key, value)
    bucket_index = hash(key) % (capacity - 1)
    if buckets[bucket_index].contains?(key)
      buckets[bucket_index].overwrite_value_of_existing_key(key, value)
    else
      buckets[bucket_index].prepend([key, value])
    end
    double_capacity if length >= key_limit
  end

  def get(key)
    buckets.each do |bucket|
      node = bucket.find(key)
      return node.data[1] unless node.nil?
    end
    nil
  end

  def has?(key)
    buckets.each { |bucket| return true if bucket.contains?(key) }
    false
  end

  def remove(key)
    buckets.each do |bucket|
      node = bucket.find(key)
      next unless node

      return bucket.delete_existing_node(node)
    end
    nil
  end

  def length
    count = 0
    buckets.each { |bucket| count += bucket.size }
    count
  end

  def clear
    capacity = 16
    self.buckets = Array.new(capacity) { Bucket.new }
  end

  def keys
    keys = []
    buckets.each do |bucket|
      bucket.entries.each { |entry| keys << entry[0] }
    end
    keys
  end

  def to_s
    puts "Current capacity: #{capacity}"
    puts "Load factor: #{load_factor}"
    puts "Current key limit: #{key_limit}"
    puts "Current length: #{length}"
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
    capacity.times { buckets << Bucket.new }
    self.capacity = buckets.length
  end
end
