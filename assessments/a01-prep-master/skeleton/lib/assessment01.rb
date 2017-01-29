require 'byebug'
class Array

  # Monkey patch the Array class and add a my_inject method. If my_inject receives
  # no argument, then use the first element of the array as the default accumulator.

  def my_inject(accumulator = nil, &prc)
    accumulator = self.shift if accumulator.nil?

    self.each do |el|
      accumulator = yield(accumulator,el)
    end
    accumulator
  end
end

# primes(num) returns an array of the first "num" primes.
# You may wish to use an is_prime? helper method.

def is_prime?(num)
  return false if num < 2
  (2...num).none? {|n| num % n == 0}
end

def primes(num)
  result = []
  i = 0
  until result.length == num
    result << i if is_prime?(i)
    i+=1
  end
  result
end

# Write a recursive method that returns the first "num" factorial numbers.
# Note that the 1st factorial number is 0!, which equals 1. The 2nd factorial
# is 1!, the 3rd factorial is 2!, etc.

def factorials_rec(num)
  return [1] if num == 1

  factors = factorials_rec(num - 1)
  factors << (1...num).inject(:*)
end

class Array

  # Write an Array#dups method that will return a hash containing the indices of all
  # duplicate elements. The keys are the duplicate elements; the values are
  # arrays of their indices in ascending order, e.g.
  # [1, 3, 4, 3, 0, 3, 0].dups => { 3 => [1, 3, 5], 0 => [4, 6] }

  def dups
    result = {}
    self.each_with_index do |element, index|
      result[element] = [] unless result[element]
      result[element] << index
    end
    result.select {|key,value| value.length > 1}
  end
end

class String

  # Write a String#symmetric_substrings method that returns an array of substrings
  # that are palindromes, e.g. "cool".symmetric_substrings => ["oo"]
  # Only include substrings of length > 1.

  def symmetric_substrings
    result = []
    (0...self.length - 1).each do |start|
      (start+1..self.length - 1).each do |finish|
        word = self[start..finish]
        result << word if word == word.reverse
      end
    end
    result
  end

end

class Array

  # Write an Array#merge_sort method; it should not modify the original array.

  def merge_sort(&prc)
    return self if self.length <= 1
    prc ||= Proc.new {|x,y| x <=> y}

    middle_index = self.length/2
    left = self.take(middle_index).merge_sort(&prc)
    right = self.drop(middle_index).merge_sort(&prc)
    Array.merge(left,right,&prc)
  end

  private
  def self.merge(left, right, &prc)
    result = []

    until left.empty? || right.empty?
      if prc.call(left.first,right.first) < 1
        result << left.shift
      else
        result << right.shift
      end
    end
    result + left + right
  end
end
