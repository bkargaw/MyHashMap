class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
    @next.prev = @prev
    @prev.next = @next
  end
end

class LinkedList
  include Enumerable

  def initialize
    @head = Link.new
    @head.next = @head
    @head.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    return nil if @head == @head.next
    @head.next
  end

  def last
    return nil if @head == @head.prev
    @head.prev
  end

  def empty?
    first == nil
  end

  def get(key)
    each { |node| return node.val if node.key == key }
    nil
  end

  def include?(key)
    each { |node| return true if node.key == key }
    false
  end

  def append(key, val)
    node = Link.new(key, val)
    if empty?
      @head.next = node
      @head.prev = node
      node.prev = @head
      node.next = @head
    else
      @head.prev.next = node
      node.prev = @head.prev
      @head.prev = node
      node.next = @head
    end
  end

  def update(key, val)
    each { |node| node.val = val if node.key == key }
  end

  def remove(key)
    each { |node| node.remove if node.key == key }
  end

  def each
    node = @head.next

    while (node != @head)
      yield node
      node = node.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  # end
end
