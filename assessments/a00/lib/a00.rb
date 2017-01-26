# Back in the good old days, you used to be able to write a darn near
# uncrackable code by simply taking each letter of a message and incrementing it
# by a fixed number, so "abc" by 2 would look like "cde", wrapping around back
# to "a" when you pass "z".  Write a function, `caesar_cipher(str, shift)` which
# will take a message and an increment amount and outputs the encoded message.
# Assume lowercase and no punctuation. Preserve spaces.
#
# To get an array of letters "a" to "z", you may use `("a".."z").to_a`. To find
# the position of a letter in the array, you may use `Array#find_index`.

def caesar_cipher(str, shift)
  dictionary = ("a".."z").to_a
  new_array = []
  str.split("").each do |letter|
    index_letter = dictionary.find_index(letter)
    if index_letter.nil?
      new_array << letter
    else
      new_index = (index_letter + shift) % 26

      new_array << dictionary[new_index]
    end
  end
  new_array.join
end

# Write a method, `digital_root(num)`. It should Sum the digits of a positive
# integer. If it is greater than 10, sum the digits of the resulting number.
# Keep repeating until there is only one digit in the result, called the
# "digital root". **Do not use string conversion within your method.**
#
# You may wish to use a helper function, `digital_root_step(num)` which performs
# one step of the process.

def digital_root(num)

  total = digital_root_step(num)
  until total < 10
    total = digital_root_step(total)
  end
  total
end

def digital_root_step(num)

  #digits = num.to_s.split("").map(&:to_i)
  digits = get_digits(num)
  digits.inject(0) do |result, number|
    result + number
  end
end

def get_digits(num)
  digits = []
  digits << num%10
  num = num/10
  until num == 0
    digits << num%10
    num = num/10
  end
  digits.reverse
end

# Jumble sort takes a string and an alphabet. It returns a copy of the string
# with the letters re-ordered according to their positions in the alphabet. If
# no alphabet is passed in, it defaults to normal alphabetical order (a-z).

# Example:
# jumble_sort("hello") => "ehllo"
# jumble_sort("hello", ['o', 'l', 'h', 'e']) => 'ollhe'

def jumble_sort(str, alphabet = nil)
  alphabet ||= ("a".."z").to_a

  new_string = str.split("").sort do |letter_a, letter_b|
    alphabet.find_index(letter_a) <=> alphabet.find_index(letter_b)
  end
  new_string.join
end

class Array
  # Write a method, `Array#two_sum`, that finds all pairs of positions where the
  # elements at those positions sum to zero.

  # NB: ordering matters. I want each of the pairs to be sorted smaller index
  # before bigger index. I want the array of pairs to be sorted
  # "dictionary-wise":
  #   [0, 2] before [1, 2] (smaller first elements come first)
  #   [0, 1] before [0, 2] (then smaller second elements come first)

  def two_sum
    pair_sums = []
    (0...self.length-1).each do |index|
      (index+1...self.length).each do |index_2|
        if self[index] + self[index_2] == 0
          pair_sums << [index, index_2]
        end
      end
    end
    pair_sums
  end
end

class String
  # Returns an array of all the subwords of the string that appear in the
  # dictionary argument. The method does NOT return any duplicates.

  def real_words_in_string(dictionary)
    subwords = []
    (0..self.length).each do |index|
      (1..self.length).each do |size|
        if dictionary.include?(self[index,size])
          unless subwords.include?(self[index,size])
            subwords << self[index,size]
          end
        end
      end
    end
    subwords
  end
end

# Write a method that returns the factors of a number in ascending order.

def factors(num)
  factors = []
  (1..num).each do |factor|
    factors << factor if num % factor == 0
  end
  factors
end
