class RankingsController < ApplicationController
  def index
    @ranks = Rank.order(date: :desc)
  end
end
