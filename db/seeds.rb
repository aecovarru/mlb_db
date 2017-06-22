module Builder
  game_date = GameDate.today
  Stats.games(game_date)
  game_date = GameDate.tomorrow
  Stats.games(game_date)
end
