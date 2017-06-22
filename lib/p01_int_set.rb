require('byebug')
class MaxIntSet
  attr_reader :store, :max
  def initialize(max)
    @store = Array.new(max, false)
  end

  def insert(num)
    validate!(num)
    return false if @store[num]
    @store[num] = true
  end

  def remove(num)
    @store[num] = false
  end

  def include?(num)
    store[num]
  end

  private

  def is_valid?(num)
    num.between?(0, @store.length - 1)
  end

  def validate!(num)
    raise "Out of bounds" unless is_valid?(num)
  end
end


class IntSet
  attr_reader :store
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    return false if include?(num)
    self[num].push(num)
  end

  def remove(num)
    self[num].delete_if { |e| e == num } if include?(num)
  end

  def include?(num)
    self[num].each { |el| return true if el == num }
    false
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count, :store

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    resize! if num_buckets == count
    return false if include?(num)
    self[num].push(num)
    @count += 1
  end

  def remove(num)
    if include?(num)
      self[num].delete_if { |e| e == num }
      @count -= 1
    end
  end

  def include?(num)
    self[num].each { |el| return true if el == num }
    false
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_store = ResizingIntSet.new(num_buckets * 2)
    @store.each do |array|
      array.each { |num| new_store.insert(num) }
    end
    @store = new_store.store
  end
end
