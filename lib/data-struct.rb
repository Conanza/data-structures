
require_relative "doubly_linked_list"
require_relative "dynamic_array"
require_relative "max_stack"
require_relative "min_max_stack"
require_relative "singly_linked_list"
require_relative "stack_queue"

class DataStruct
  def self.LinkedList
    LinkedList.new
  end

  def self.DynamicArray(size)
    DynamicArray.new(size)
  end
end