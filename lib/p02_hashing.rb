require 'byebug'
class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    hash = 0
    each_with_index do |el, idx|
      hash += el.hash * idx
    end
    hash
  end
end

class String
  def hash
    hash = 0
    each_char.with_index do |char, idx|
      hash += char.ord.hash * idx
    end
    hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    hash = 0
    each do |key, value|
      hash += key.hash + value.hash
    end

    hash
  end
end
