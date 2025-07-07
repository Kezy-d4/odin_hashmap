require_relative "node"
# A blueprint for instantiating a new linked list for use in a hashmap. This
# hashmap implementation will instantiate an empty linked list for each of its
# buckets. When a key hashes to a certain bucket index, it and its value will be
# prepended to the linked list contained there in the form of a node containing
# a two-index array.
class LinkedList
  attr_accessor :head

  def initialize
    @head = nil
  end

  def prepend(data)
    node = Node.new(data)
    node.next_node = head
    self.head = node
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
