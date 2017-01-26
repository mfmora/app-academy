require "byebug"

class Array
  def my_each(&prc)
    #debugger
    i = 0
    while i < self.length
      prc.call(self[i])
      i+=1
    end
    self
  end

  def my_select(&block)
    selected = []
    self.my_each do |ele|
      selected << ele if block.call(ele)
    end

    selected
  end

  def my_reject(&block)
    rejected = []
    self.my_each do |ele|
      rejected << ele unless block.call(ele)
    end
    rejected
  end

  def my_any?(&block)
    self.my_each do |ele|
      return true if block.call(ele)
    end
    false
  end

  def my_all?(&block)
    self.my_each do |ele|
      return false unless block.call(ele)
    end
    true
  end

  def my_flatten
    flatten = []
    self.my_each do |ele|
      debugger
      if ele.is_a?(Array)
        deep_flatten = ele.my_flatten
        flatten.concat(deep_flatten)
      else
        flatten << ele
      end
    end

    flatten
  end

  def my_zip(*args)
    zipped = []

    self.each_with_index do |ele, idx|
      deep_zipped = [ele]
      args.my_each do |args_ele|
        deep_zipped << args_ele[idx]
      end
      zipped << deep_zipped
    end

    zipped
  end

  def my_rotate(shift = 1)
    rotated = []

    self.each_with_index do |ele, idx|
      new_index = (idx - shift) % self.length
      rotated[new_index] = ele
    end

    rotated
  end

  def my_join(separator = "")
    joined = ""

    self.each_with_index do |ele, idx|
      joined << ele
      joined << separator unless idx == self.length - 1
    end

    joined
  end

  def my_reverse
    reversed = []

    self.each_with_index do |ele, idx|
      reversed[self.length-1-idx] = ele
    end

    reversed
  end

  def bubble_sort!(&prc)
    prc ||= Proc.new { |x, y| x <=> y }

    sorted = false
    until sorted
      sorted = true
      self.each_with_index do |ele, x|
        next if x + 1 == self.length

        if prc.call(self[x], self[x + 1]) == 1
          sorted = false
          self[x], self[x + 1] = self[x + 1], self[x]
        end
      end
    end

    self
  end

  def bubble_sort(&prc)
    self.dup.bubble_sort!(&prc)
  end

end

def factors(num)
  factor = []

  (1..num).each do |number|
    factor << number if num % number == 0
  end
  factor
end

def substrings(string)
  subs = []

  string.length.times do |substart|
    (substart...string.length).each do |subend|
      subs << string[substart..subend]
    end
  end

  subs
end

def subwords(word, dictionary)
  words = []
  subs = substrings(word)
  subs.each do |sub_word|
    words << sub_word if dictionary.include?(sub_word)
  end
  words
end
