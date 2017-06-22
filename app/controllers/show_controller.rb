class ShowController < ApplicationController
  def game
    @game = Game.find(params[:id])
    @away_team = @game.away_team
    @home_team = @game.home_team
    @away_batters = @game.away_batters
    @home_batters = @game.home_batters
    @away_pitchers = @game.away_pitchers
    @home_pitchers = @game.home_pitchers
  end
end
