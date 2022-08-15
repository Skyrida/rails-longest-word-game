require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = []
    x = 0
    until x == 10
      alphabet = ('a'..'z').to_a
      letter = alphabet[rand(0..25)]
      @letters << letter
      x += 1
    end
    @letters
  end

  def score
    @word = params[:word]
    word_split = params[:word].split('')
    @letters = params[:letters]
    @letters_split = params[:letters].split(' ')
    truthful = []
    word_split.each do |character|
      result = @letters_split.include?(character).to_s
      truthful << result
    end
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    word_serialized = URI.open(url).read
    dictionary_word = JSON.parse(word_serialized)
    @result =
      if truthful.include?('false')
        "Sorry but #{@word.upcase} can't be built out of #{@letters}"
      elsif dictionary_word['found'] == true
        "CONGRATULATIONS! #{@word.upcase} is a valid English word!"
      else
        "Sorry but #{@word.upcase} doesn't seem to be a valid English word..."
      end
  end
end
