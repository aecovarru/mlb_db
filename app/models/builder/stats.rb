module Builder
  module Stats
    extend self

    def games(game_date)
      game_stats = BaseballPress::Games.stats(game_date)
      games = game_stats.map {|stat| Game.find_or_create_by(stat)}
      player_stats = BaseballPress::Players.stats(game_date)
      batters = player_stats[:batters].map {|stat| Batter.find_or_create_by(stat)}
      pitchers = player_stats[:pitchers].map {|stat| Pitcher.find_or_create_by(stat)}
      season = game_date.season
      teams = player_stats[:teams]
      teams.each do |team|
        team_games = games.select {|game| game.away_team == team || game.home_team == team}
        team_games.each do |game|
          pitchers(season, team, game)
          batters(season, team, game)
        end
      end
    end

    def pitchers(season, team, intervalable)
      stats = Fangraphs::Pitchers.stats(season, team)
      save_stats(Pitcher, stats, intervalable)
    end

    def batters(season, team, intervalable)
      stats = Fangraphs::Batters.stats(season, team)
      save_stats(Batter, stats, intervalable)
    end

    def save_stats(model, stats, intervalable)
      stats.each do |name, player_stats|
        player = Player.find_by_name(name)
        athlete = model.find_by(intervalable: intervalable, statable: player) if player
        if athlete
          key = model == Batter ? :batter : :pitcher
          stat_model = model == Batter ? BatterStat : PitcherStat
          player_stats.each do |version, stat|
            player_stat = stat_model.find_or_create_by(key => athlete, stat_type: version)
            player_stat.update(stat)
          end
        else
          stats.delete(name)
        end
      end
    end
  end
end
