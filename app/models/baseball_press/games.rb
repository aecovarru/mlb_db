module BaseballPress
  module Games
    extend self
    extend Download

    def stats(game_date)
      url = "http://www.baseballpress.com/lineups/%d-%02d-%02d" % [game_date.year, game_date.month, game_date.day]
      doc = download_file(url)
      info = game_info(doc)
      away_teams = []
      game_stats = info[:away_teams].zip(info[:home_teams]).map do |away_team, home_team|
        if info[:duplicates].include?(away_team)
          num = away_teams.include?(away_team) ? 2 : 1
        else
          num = 0
        end
        away_teams << away_team
        {game_date: game_date, away_team: away_team, home_team: home_team, num: num}
      end
      return game_stats
    end

    def game_info(doc)
      team_names = doc.css(".team-name").map(&:text)
      away_teams = team_names.select.with_index { |_, index| index%2 == 0 }.map { |name| Team.find_by_name(name) }
      home_teams = team_names.select.with_index { |_, index| index%2 == 1 }.map { |name| Team.find_by_name(name) }
      duplicates = team_names.select { |name| team_names.count(name) > 1 }.map { |name| Team.find_by_name(name) }
      return { away_teams: away_teams, home_teams: home_teams, duplicates: duplicates }
    end
  end
end
