require_relative "node"

# A blueprint for instantiating a new linked list for use in a hashmap. This
# hashmap implementation will instantiate an empty linked list for each of its
# buckets. The instance methods available in this linked list class are designed
# largely around what is necessary to implement the hashmap, though are also
# flexible where possible.
class Bucket # rubocop:disable Metrics/ClassLength
  private

  attr_accessor :head

  public

  def initialize
    @head = nil
  end

  def prepend(data)
    node = Node.new(data)
    node.next_node = head
    self.head = node
  end

  def contains?(key)
    current = head
    until current.nil?
      return true if current.data[0] == key

      current = current.next_node
    end
    false
  end

  def overwrite_value_of_existing_key(key, value)
    current = head
    current = current.next_node until current.data[0] == key
    current.data[1] = value
  end

  def find(key)
    current = head
    until current.nil?
      return current if current.data[0] == key

      current = current.next_node
    end
    nil
  end

  def delete_head
    return if empty?

    self.head = (only_node?(head) ? nil : head.next_node)
  end

  def pop
    return if empty?
    return self.head = nil if only_node?(head)

    previous = nil
    current = head
    until current.next_node.nil?
      previous = current
      current = current.next_node
    end
    previous.next_node = nil
  end

  def delete_middle(node)
    return if empty?
    return if head?(node) || tail?(node)

    previous = nil
    current = head
    until current == node
      previous = current
      current = current.next_node
    end
    previous.next_node = current.next_node
  end

  def delete_existing_node(node)
    if head?(node)
      delete_head
    elsif tail?(node)
      pop
    elsif middle?(node)
      delete_middle(node)
    end
  end

  def size
    count = 0
    current = head
    until current.nil?
      count += 1
      current = current.next_node
    end
    count
  end

  def empty?
    head.nil?
  end

  def to_s
    print "Data in list: "
    current = head
    until current.nil?
      print "(#{current.data}) -> "
      current = current.next_node
    end
    print "nil "
  end

  private

  def head?(node)
    !empty? && node == head
  end

  def only_node?(node)
    !empty? && head?(node) && node.next_node.nil?
  end

  def tail?(node)
    !empty? && !only_node?(node) && !head?(node) && node.next_node.nil?
  end

  def middle?(node)
    !empty? && !only_node?(node) && !head?(node) && !tail?(node)
  end
end
