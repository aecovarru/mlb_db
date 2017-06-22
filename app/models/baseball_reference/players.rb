module BaseballReference
  module Players
    extend self
    extend Download
    def stats(season, team)
      css = "#appearances tbody .left, #appearances .right" 
		  url = "http://www.baseball-reference.com/teams/#{team.abbr}/#{season.year}-roster.shtml"
      doc = download_file(url)
      data = table_data(doc, css)
      size = 29
      player_data = data.each_slice(size).map do |slice|
        name = slice[0].text
        puts slice[0].text
        identity = slice[0].identity
        bathand = slice[3].text
        throwhand = slice[4].text
        is_pitcher = slice[13].text.to_i != 0
        { name: name, identity: identity, bathand: bathand, throwhand: throwhand }
      end
      return player_data
    end
  end
end
