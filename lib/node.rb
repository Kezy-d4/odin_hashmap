# A blueprint for instantiating a new node for use in a linked list. For the
# purposes of this hashmap implementation, a node will be instantiated with its
# data being a two-index array where index 0 stores a key and index 1 stores
# said key's value.
class Node
  attr_accessor :data, :next_node

  def initialize(data = nil, next_node = nil)
    @data = data
    @next_node = next_node
  end
end
