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

end
