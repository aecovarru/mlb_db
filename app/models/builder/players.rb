module Builder
  module Players
    extend self
    def create(season)
      teams = season.teams
      teams.each do |team|
        stats = BaseballReference::Players.stats(season, team)
        stats.each do |stat|
          player_stat = stat.merge({season: season, team: team})
          Player.find_or_create_by(player_stat)
        end
      end
    end
  end
end
