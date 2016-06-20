class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  attr_accessor :word, :guesses, :wrong_guesses, :word_with_guesses, :check_win_or_lose

  def initialize(word)
    @word = word
    @guesses = ""
    @wrong_guesses = ""
    @check_win_or_lose = :play
  end

  def guess(guess_made)

    guess_made.downcase! unless guess_made.nil? #to make the guess case-insensitive
    raise ArgumentError unless guess_made =~ /^[a-z]$/

    #if guess is already made do nothing
    if @guesses.include? guess_made or @wrong_guesses.include? guess_made
      false
    #otherwise modify guesses and wrong_guesses accordingly
    else
      if @word.include? guess_made
        @guesses += guess_made
      else
        @wrong_guesses += guess_made
      end
      @word_with_guesses = ""

      #construct the word guessed so far
      @word.chars do |char|
        @word_with_guesses += @guesses.include?(char) ? char : "-"
      end

      #Update the status of the game
      if @wrong_guesses.length == 7
        @check_win_or_lose = :lose
      elsif @word == @word_with_guesses
        @check_win_or_lose = :win
      end
      true
    end
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
