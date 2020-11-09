require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { [*'a'..'z'].sample }.join
  end

  def included?(word, random)
    word.chars.all? { |letter| word.count(letter) <= random.count(letter) }
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    return json['found']
  end

  def score
    @letters = params[:letters]
    @word = params[:word]
    @included = included?(@word, @letters)
    @english_word = english_word?(@word)
  end
end

# Make sure you are validating that 1) your word is an actual English word, and
# 2) that every letter in your word appears in the grid (remember you can only use each letter once).
# If the word is not valid or is not in the grid, the score will be 0
# (and should be accompanied by a message to the player explaining why they didn't score any points).
