module Builder
  module Games
    extend self
    def create(season)
      season.teams.each do |team|
        stats = BaseballReference::Games.stats(season, team)
        stats.each do |stat|
          date = stat.delete(:date)
          game_date = GameDate.find_or_create_by(season: season, date: date)
          stat[:game_date] = game_date 
          Game.create(stat)
        end
      end
    end
  end
end
