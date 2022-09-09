class GamesController < ApplicationController
  require 'open-uri'
  require 'json'

  def new
    @letters = []
    8.times { @letters << ('A'..'Z').to_a.sample }
  end

  def score
    @letters = params[:letters]
    @attempt = params[:word]
    @result = {
      score: 0,
      message: 'is a great choice!'
    }
    @result[:message] = 'is not an english word' unless word_validation(@attempt)
    @result[:message] = "is not in the grid, #{@letters}" if !grid_validation(@attempt, @letters) || !grid_repeat(@attempt, @letters)
    @result[:score] = @attempt.length * 10 if @result[:message] == 'is a great choice!'
  end

  def word_validation(attempt)
    JSON.parse(URI.open("https://wagon-dictionary.herokuapp.com/#{@attempt}").read)['found']
  end

  def grid_validation(attempt, grid)
    attempt.upcase.chars.all? { |letter| grid.include?(letter) }
  end

  def grid_repeat(attempt, grid)
    attempt.upcase.chars.all? do |letter|
      attempt.upcase.chars.count(letter) <= grid.count(letter)
    end
  end
end
