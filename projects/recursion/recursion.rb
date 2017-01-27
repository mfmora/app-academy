def range(start, finish)
  return [] if start+1 >= finish
  recursive = []

  recursive << start+1
  recursive += range(start+1, finish-1)
  recursive << finish-1 unless recursive.include?(finish-1)

  recursive
end

def sum_iterative(array)
  array.inject(&:+)
end

def sum_recursion(array)
  return 0 if array.empty?
  array.pop + sum_recursion(array)
end


def recursion_one(b, n)
  return 1 if n == 0

  b * recursion_one(b, n - 1)
end

def recursion_two(b, n)
  return 1 if n == 0
  return b if n == 1

  if n % 2 == 0
    result = recursion_two(b, n/2)
    result*result
  else
    result = recursion_two(b, (n - 1) / 2)
    b*result*result
  end

end

def fibonacci_recursive(n)
  if n <= 2
    [0, 1].take(n)
  else
    recursive = fibonacci_recursive(n-1)
    recursive << recursive[-1] + recursive[-2]
  end
end

def fibonacci_iterative(n)
  return nil if n < 1
  return [0] if n == 1
  fib_array = [0,1]

  (0...(n - 2)).each do |i|
    fib_array << fib_array[i] + fib_array[i+1]
  end
  fib_array
end

def subsets(array)
  return [[]] if array.empty?
  last_el = array.pop
  recursion_subs = subsets(array)
  new_subs = recursion_subs.deep_dup.map { |el| el << last_el }
  recursion_subs + new_subs
end

def permutations(array)
  return [array] if array.length <= 1
  final_array = []
  array.each_with_index do |element, index|
    recursive = permutations(array[0...index] + array[index+1..-1])
    final_array += recursive.map {|rec| rec.unshift(element)}
  end

  final_array
end

require 'byebug'
def bsearch(array, target)
  middle_position = (array.length - 1)/2
  return middle_position if target == array[middle_position]
  return nil if array.length <= 1

  if target > array[middle_position]
    right_array = array[middle_position+1..-1]
    position = bsearch(right_array, target)
    return nil if position.nil?
    middle_position + 1 + position
  else
    left_array = array[0...middle_position]
    position = bsearch(left_array, target)
    return nil if position.nil?
    position
  end
end

class Array
  def deep_dup
    self.map { |el| el.is_a?(Array) ? el.deep_dup : el}
  end
end

def merge(left_array, right_array)
  result = []
  until left_array.empty? || right_array.empty?
    if left_array[0] < right_array[0]
      result << left_array.shift
    else
      result << right_array.shift
    end
  end

  result += left_array.empty? ? right_array : left_array
end

def merge_sort(array)
  return array if array.length <= 1
  middle = (array.length - 1)/2
  left_array = array[0..middle]
  right_array = array[middle+1..-1]

  merge(merge_sort(left_array), merge_sort(right_array))

end

def greedy_make_change(value, denominations)
  return [] if denominations.empty?
  change = []
  biggest = denominations.shift
  while value > 0 && value >= biggest
    value-=biggest
    change << biggest
  end
  if value > 0
    change += greedy_make_change(value, denominations)
  end
  change
end

def make_better_change(value, denominations)
  return [] if denominations.empty?
  best_change = []
  denominations.each do |coin|
    if value >= coin
      change = []
      remainder = value - coin
      change << coin
      remainder_coins = denominations.select {|denom| denom <= remainder}
      change += make_better_change(remainder, remainder_coins)
      if best_change.length > change.length || best_change.length == 0
        best_change = change
      end
    end
  end

  best_change
end

def make_best_change(value, denominations)
  return [] if denominations.empty?
  best_change = nil
  denominations.each do |coin|
    if value >= coin
      change = []
      remainder = value
      while remainder > 0 && remainder >= coin
        remainder-=coin
        change << coin
      end
      remainder_coins = denominations.select {|denom| denom <= remainder}
      change += make_better_change(remainder, remainder_coins)

      if best_change.nil? || best_change.length > change.length
        best_change = change
      end
    end
  end

  best_change
end
