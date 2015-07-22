
class BSTNode
  attr_reader :value
  attr_accessor :parent, :left, :right, :depth, :balance

  def initialize(value)
    @value = value
    @parent = EmptyNode.new
    @left = EmptyNode.new
    @right = EmptyNode.new
    @depth = 1
    @balance = 0
  end

  def self.from_array(array)
    BSTNode.new(array.first).tap do |tree|
      array.each { |val| tree.insert(val) }
    end
  end

  def left_rotate
    new_left = BSTNode.new(value)

    new_left.left = left
    # (left && left.right) || EmptyNode.new
    new_left.right = right.left
    new_left.parent = self

    new_right = right.right
    right.right.parent = self
    
    @value, @left, @right = right.value, new_left, new_right
  end

  def right_rotate
    new_right = BSTNode.new(value)

    new_right.right = right
    new_right.left = left.right
    new_right.parent = self

    new_left = left.left
    left.left.parent = self
    # new_right.left, new_right.right, new_right.parent = left.right, right, self
    # new_left, new_left.parent = left.left, self

    @value, @left, @right = left.value, new_left, new_right
  end

  def insert(val)
    case val <=> value
    when -1 then insert_left(val)
    when 1 then insert_right(val)
    when 0 then false
    end

    self
  end

  def inspect
    " { #{value}, DEPTH: #{depth}, BALANCE: #{balance} : #{left.inspect} | #{right.inspect} } "
  end

  def include?(val)
    case val <=> value
    when -1 then left.include?(val)
    when 1 then right.include?(val)
    when 0 then true
    end
  end

  def to_a
    left.to_a + [value] + right.to_a
  end

  def recalculate_depth_and_balance
    @depth = ([left.depth, right.depth].max + 1)
    @balance = right.depth - left.depth
  end

  def update_depth_and_balance
    recalculate_depth_and_balance
    rebalance if ([-2, 2].include?(@balance))
    parent.update_depth_and_balance
  end

  private

  def insert_left(val)
    if (left.class != EmptyNode)
      left.insert(val)
    else
      new_node = BSTNode.new(val)
      self.left, new_node.parent = new_node, self
      new_node.update_depth_and_balance
    end
  end

  def insert_right(val)
    if (right.class != EmptyNode)
      right.insert(val)
    else
      new_node = BSTNode.new(val)
      self.right, new_node.parent = new_node, self
      new_node.update_depth_and_balance
    end
  end

  def rebalance
    if @balance == -2
      left.left_rotate if left.balance == 1
      right_rotate
    elsif @balance == 2
      right.right_rotate if right.balance == -1
      left_rotate
    end
    right.recalculate_depth_and_balance
    left.recalculate_depth_and_balance
  end
end

class EmptyNode
  attr_reader :depth
  attr_accessor :parent

  def initialize
    @depth = 0
    @parent = nil
  end

  def include?(*)
    false
  end

  def insert(*)
    false
  end

  def inspect
    "{ }"
  end

  def recalculate_depth_and_balance
    true
  end

  def to_a
    []
  end

  def update_depth_and_balance
    true
  end
end

test_array = [173,]
3000.times { test_array << (rand 5000) }
count = 0

# test_array = [
#   173,
#   2735,
#   4973,
#   2403,
#   4789,
#   1044,
#   106,
#   489,
#   179,
#   2387,
#   1079,
#   441,
#   4387,
#   227,
#   641,
#   1306,
#   3219,
#   2787,
#   3195,
#   1087
# ]

tree = BSTNode.new(test_array.first)
test_array.each do |v|
  # puts "\n\n"
  # p "OLD TREE = #{tree.inspect}"
  p "#{v}" 
  tree.insert(v)
  p "TREE = #{tree.inspect}"
  # p "DEPTH = #{tree.depth}"
  # p "BALANCE = #{tree.balance}"
  # p count
end

