require 'set'
class WordChainer

  def initialize(dictionary_file_name)
    @dictionary = Set.new(File.readlines.map(&:chomp))
  end

  def adjacent_words(word)
    
  end
end
