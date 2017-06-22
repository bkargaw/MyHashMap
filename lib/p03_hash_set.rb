require_relative 'p02_hashing'

class HashSet
  attr_reader :count, :store

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    resize! if num_buckets == count
    return false if include?(key)
    self[key].push(key)
    @count += 1
  end

  def include?(key)
    self[key].each { |el| return true if el == key }
    false
  end

  def remove(key)
    if include?(key)
      @count -= 1
      self[key].delete_if { |el| el == key }
    end
  end

  private

  def [](key)
    # optional but useful; return the bucket corresponding to `num`
    @store[hash(key) % num_buckets]
  end

  def hash(key)
    key.hash
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_set = HashSet.new(num_buckets * 2)
    @store.each do |array|
      array.each { |el| new_set.insert(el) }
    end

    @store = new_set.store
  end

end
