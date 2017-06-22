module Fangraphs
  module Players
    extend self
    extend Download
    def player_data(team)
      url = "http://www.fangraphs.com/depthcharts.aspx?position=ALL&teamid=#{team.fangraph_id}"
      doc = download_file(url)
      batter_css = ".depth_chart:nth-child(58) td"
      pitcher_css = ".depth_chart:nth-child(76) td"
      batter_data = table_data(doc, batter_css)
      pitcher_data = table_data(doc, pitcher_css)
      batter_data = parse_player_data(batter_data)
      pitcher_data = parse_player_data(pitcher_data)
      return batter_data + pitcher_data
    end

    def parse_player_data(data)
      return data.each_slice(10).map do |slice|
        name = slice[0].fangraph_name
        fangraph_id = slice[0].fangraph_id
        { fangraph_id: fangraph_id, name: name }
      end
    end
  end
end
