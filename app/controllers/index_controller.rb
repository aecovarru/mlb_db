class IndexController < ApplicationController
  before_action :confirm_logged_in
  def home
    @yesterday = GameDate.yesterday
    @today = GameDate.today
    @tomorrow = GameDate.tomorrow
  end

  def players
  end

  def games
    @game_date = GameDate.find(params[:id])
    @games = @game_date.games
  end
end
