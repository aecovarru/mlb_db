module BaseballReference
  module Games
    extend self
    extend Download
    CSS = "#team_schedule td"
    SIZE = 19
    def stats(season, team)
      url = "http://www.baseball-reference.com/teams/#{team.abbr}/#{season.year}-schedule-scores.shtml"
      doc = download_file(url)
      data = table_data(doc, CSS)
      slices = data.each_slice(SIZE)
      game_data = slices.map do |slice|
        date = slice[0].date
        next unless date
        away_team, home_team = away_home_teams(slice)
        num = slice[0].num
        { date: date, away_team: away_team, home_team: home_team, num: num }
      end
      return game_data.compact
    end

    def away_home_teams(slice)
      team = Team.find_by_abbr(slice[2].text)
      opp = Team.find_by_abbr(slice[4].text)
      return slice[3].text.empty? ? [opp, team] : [team, opp]
    end
  end
end
