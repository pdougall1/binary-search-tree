class Node
  attr_reader :value
  attr_accessor :left, :right

  def initialize(value)
    @value = value
  end

  def insert(new_value)
    return true if new_value == value
    return insert_right(new_value) if new_value > value
    return insert_left(new_value)  if new_value < value
  end

  def include?(checked_value)
    return true if checked_value == value
    return include_right?(checked_value) if checked_value > value
    return include_left?(checked_value)  if checked_value < value
  end

  def insert_left(new_value)
    if self.left
      self.left.insert(new_value)
    else
      self.left = Node.new(new_value)
    end
  end

  def insert_right(new_value)
    if self.right
      self.right.insert(new_value)
    else
      self.right = Node.new(new_value)
    end
  end

  def include_left?(checked_value)
    if self.left
      self.left.include?(checked_value)
    else
      false
    end
  end

  def include_right?(checked_value)
    if self.right
      self.right.include?(checked_value)
    else
      false
    end
  end
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

node = Node.new(10)
node.insert(5)
assert_eq(node.left.value, 5, "Left insert")
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
