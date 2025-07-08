require_relative "node"

# A blueprint for instantiating a new linked list for use in a hashmap. This
# hashmap implementation will instantiate an empty linked list for each of its
# buckets.
class LinkedList
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

  def to_s
    print "Data in list: "
    current = head
    until current.nil?
      print "(#{current.data}) -> "
      current = current.next_node
    end
    print "nil "
  end
end
