module Builder
  Seasons.create([2017])
  season = Season.find_by_year(2017)
  Players.create(season)
  Games.create(season)
  game_date = GameDate.today
  Stats.games(game_date)
end
