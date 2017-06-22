module Fangraphs
  module Pitchers
    extend self
    extend Download
    PARAMS = [
      { version: "B", month: 0, data: "1", size: 16, indices: { name: 1, fip: 11, siera: 15 } },
      { version: "30", month: 3, data: "c,47,42,13,24,19,122", size: 8, indices: { name: 1, ld: 2, whip: 3, ip: 4, so: 5, bb: 6, siera: 7 } },
      { version: "L", month: 13, data: "c,36,31,4,14,11,5,38,43,27,47,37,7", size: 14, indices: { name: 1, ld: 2, whip: 3, ip: 4, so: 5, bb: 6, era: 7, fb: 8, xfip: 9, kbb: 10, woba: 11, gb: 12, h: 13 } },
      { version: "R", month: 14, data: "c,36,31,4,14,11,5,38,43,27,47,37,7", size: 14, indices: { name: 1, ld: 2, whip: 3, ip: 4, so: 5, bb: 6, era: 7, fb: 8, xfip: 9, kbb: 10, woba: 11, gb: 12, h: 13 } }
    ]

    def stats(season, team)
      css = ".grid_line_regular"
      @stats = {}
      PARAMS.each do |params|
        params[:year] = season.year
        params[:fangraph_id] = team.fangraph_id
        [1, 1].each do |rost|
          params[:rost] = rost
          url = build_url(params)
          doc = download_file(url)
          data = table_data(doc, css)
          rows = build_rows(data, params)
          add_stats(rows, params[:version])
        end
      end
      return @stats
    end

    def add_stats(rows, version)
      rows.each do |row|
        name = row.delete(:name)
        @stats[name] ||= {}
        @stats[name][version] ||= {}
        @stats[name][version].merge!(row)
      end
    end

    def build_rows(data, params)
      size = params[:size] + params[:rost]
      indices = params[:indices].dup
      indices.each do |key, index|
        indices[key] += params[:rost] unless key == :name
      end
      rows = data.each_slice(size).map do |slice|
        stat_array = indices.map do |key, index|
          if [:name].include?(key)
            value = slice[index].text
          elsif [:ld, :fb, :gb].include?(key)
            value = slice[index].to_f
          elsif [:whip, :ip, :so, :bb, :era, :xfip, :kbb, :siera].include?(key)
            value = slice[index].text.to_f
          elsif [:h, :fip].include?(key)
            value = slice[index].text.to_i
          end
          [key, value]
        end
        Hash[stat_array]
      end
      return rows
    end

    def build_url(params)
		  	"http://www.fangraphs.com/leaders.aspx?pos=all&stats=pit&lg=all&qual=0&type=#{params[:data]}&season=#{params[:year]}&month=#{params[:month]}&season1=#{params[:year]}&ind=0&team=#{params[:fangraph_id]}&rost=#{params[:rost]}&age=0&filter=&players=0&page=1_50"
    end
  end
end
