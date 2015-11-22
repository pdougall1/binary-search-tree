require 'pry'

class Node
  attr_reader :value
  attr_accessor :left, :right

  def initialize(value)
    nil_value_error unless value
    @value = value
    @left = EmptyNode.new
    @right = EmptyNode.new
  end

  def insert(new_value)
    return true if new_value == value
    dir, dir_name = get_dir_and_name(new_value)
    dir.insert(new_value) {
      self.send("#{dir_name}=".to_sym, Node.new(new_value))
    }
  end

  def include?(checked_value)
    return true if checked_value == value
    dir, _ = get_dir_and_name(checked_value)
    dir.include?(checked_value)
  end

  private

  def get_dir_and_name(given_value)
    direction_name = direction_map[given_value <=> value]
    direction = self.send(direction_name)
    [direction, direction_name]
  end

  def direction_map
    {
      1   => :right,
      -1  => :left,
      0   => :already_present,
      nil => :nil_value_error
    }
  end

  def nil_value_error
    raise NoMethodError, 'May not store "nil" as a value'
  end
end

class EmptyNode < Node
  def initialize(*); end
  def include?(*); false; end
  def nil_value_error; false; end
  def insert(*); yield; end
end



# TESTS
def assert_eq(given, expected, description)
  if given == expected
    puts "."
  else
    puts description
    puts "#{given} :: #{expected}"
    puts ""
  end
end

def assert_error(expected_error, description, &block)
  begin
    block.call
  rescue expected_error
    puts '.'
  rescue
    puts description
    puts block
    puts ""
  end
end


node = Node.new(10)
node.insert(5)
assert_eq(node.left.value, 5, "Left insert")
node.insert(5)
assert_eq(node.left.value, 5, "Left insert didn't get messed up")
assert_error(NoMethodError, 'insert nil value') { node.insert(nil) }
node.insert(3)
assert_eq(node.left.left.value, 3, "Left insert, when left exists")

node.insert(15)
assert_eq(node.right.value, 15, "Right insert")
node.insert(20)
assert_eq(node.right.right.value, 20, "Right insert")


assert_eq(node.include?(10), true, "the initial value")
assert_eq(node.include?(11), false, "Just above the initial value")
assert_eq(node.include?(9), false, "Just below the initial value")
assert_eq(node.include?(15), true, "the first right value")
assert_eq(node.include?(16), false, "the initial value")

assert_eq(node.include?(20), true, "the nested right value")
assert_eq(node.include?(5), true, "the first left value")
assert_eq(node.include?(3), true, "the nested left value")

assert_eq(Node.new("val").value, "val", 'Initial value')
assert_error(NoMethodError, 'initial nil value') { Node.new(nil) }

