module BaseballPress
  module Players
    extend self
    extend Download

    def stats(game_date)
      season = game_date.season
      games = game_date.games
      url = "http://www.baseballpress.com/lineups/%d-%02d-%02d" % [game_date.year, game_date.month, game_date.day]
      doc = download_file(url)
      css = ".players div, .team-name+ div, .team-name, .game-time"
      elements = doc.css(css)
      game_index = -1
      away_lineup = home_lineup = false
      away_team = home_team = nil
      team_index = pitcher_index = batter_index = 0
      away_teams = Set.new
      teams = Set.new
      pitchers = []
      batters = []
      elements.each_with_index do |element, index|
        type = element_type(element)
        case type
        when 'time'
          game_index += 1
          batter_index = 0
          away_teams << away_team if away_team
          next
        when 'lineup'
          if team_index%2 == 0
            away_team = Team.find_by_name(element.text)
            away_lineup = true
            teams << away_team
          else
            home_team = Team.find_by_name(element.text)
            home_lineup = true
            teams << home_team
          end
          team_index += 1
          next
        when 'no lineup'
          if team_index%2 == 0
            away_team = Team.find_by_name(element.text)
            away_lineup = false
            teams << away_team
          else
            home_team = Team.find_by_name(element.text)
            home_lineup = false
            teams << home_team
          end
          team_index += 1
          next
        when 'pitcher'
          if element.text == "TBD"
            pitcher_index += 1
            next
          else
            identity, fangraph_id, name, handedness = pitcher_info(element)
          end
          team = find_team_from_pitcher_index(pitcher_index, away_team, home_team)
          pitcher_index += 1
        when 'batter'
          identity, fangraph_id, name, handedness, lineup, position = batter_info(element)
          team = find_team_from_batter_index(batter_index, away_team, home_team, away_lineup, home_lineup)
          batter_index += 1
        end
        player = Player.find_by(name: name, identity: identity, team: team)
        puts name
        # Make sure player is in database, otherwise create him
        if !player
          options = {}
          if type == 'pitcher'
            options[:throwhand] = handedness
          else
            options[:bathand] = handedness
          end
          options.merge!({season: season, team: team, name: name, identity: identity})
          player = Player.create(options)
          puts "Player #{player.name} created"
        end
        game = find_game(games, away_team, away_teams)

        if type == 'pitcher'
          pitchers.push({statable: player, intervalable: game, starter: true})
        elsif type == 'batter'
          batters.push({statable: player, intervalable: game, starter: true, position: position, lineup: lineup})
        end
      end
      return {batters: batters, pitchers: pitchers, teams: teams}
    end

    def find_team_from_pitcher_index(pitcher_index, away_team, home_team)
      pitcher_index%2 == 0 ? away_team : home_team
    end

    def find_team_from_batter_index(batter_index, away_team, home_team, away_lineup, home_lineup)
      if away_lineup && home_lineup
        batter_index/9 == 0 ? away_team : home_team
      else
        away_lineup ? away_team : home_team
      end
    end

    def find_game(games, away_team, teams)
      games = games.where(away_team: away_team)
      size = games.size
      if size == 1
        return games.first
      elsif size == 2
        return teams.include?(away_team) ? games.second : games.first
      end
    end

    def element_type(element)
      element_class = element['class']
      case element_class
      when /game-time/
        type = 'time'
      when /no-lineup/
        type = 'no lineup'
      when /team-name/
        type = 'lineup'
      else
        type = element.children.size == 3 ? 'batter' : 'pitcher'
      end
      return type
    end

    def pitcher_info(element)
      name = element.child.text
      identity = element.child['data-bref']
      fangraph_id = element.child['data-razz'].gsub!(/[^0-9]/, "")
      handedness = element.children[1].text[2]
      return identity, fangraph_id, name, handedness
    end

    def batter_info(element)
      name = element.children[1].text
      lineup = element.child.to_s[0].to_i
      handedness = element.children[2].to_s[2]
      position = element.children[2].to_s.match(/\w*$/).to_s
      identity = element.children[1]['data-bref']
      fangraph_id = element.children[1]['data-razz'].gsub!(/[^0-9]/, "")
      return identity, fangraph_id, name, handedness, lineup, position
    end
  end
end
