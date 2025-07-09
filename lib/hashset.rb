require_relative "bucket"

# A blueprint for instantiating a new hashset. This is essentially a copy of the
# hashmap class except that it's designed only to handle keys and no values.
class HashSet
  private

  attr_accessor :capacity, :buckets
  attr_reader :load_factor

  public

  def initialize
    @capacity = 16
    @load_factor = 0.75
    @buckets = Array.new(capacity) { Bucket.new }
  end

  def set(key)
    bucket_index = hash(key) % capacity
    return if buckets[bucket_index].contains_hashset_key?(key)

    buckets[bucket_index].prepend(key)
    double_capacity if length > key_limit
  end

  def get(key)
    buckets.each do |bucket|
      node = bucket.find_hashset_key(key)
      return node.data unless node.nil?
    end
    nil
  end

  def has?(key)
    buckets.each { |bucket| return true if bucket.contains_hashset_key?(key) }
    false
  end

  def remove(key)
    buckets.each do |bucket|
      node = bucket.find_hashset_key(key)
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
    self.capacity = 16
    self.buckets = Array.new(capacity) { Bucket.new }
  end

  def keys
    keys = []
    buckets.each do |bucket|
      bucket.entries.each { |entry| keys << entry }
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
    entries = keys
    self.capacity *= 2
    self.buckets = Array.new(capacity) { Bucket.new }
    entries.each { |entry| set(entry) }
  end
end
