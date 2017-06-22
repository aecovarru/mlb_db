module Fangraphs
  module Batters
    extend self
    extend Download
    INDICES = { name: 1, ab: 2, sb: 3, bb: 4, so: 5, slg: 6, obp: 7, woba: 8, wrc: 9, ld: 10, gb: 11, fb: 12 }
    DATA = "c,5,21,14,16,38,37,50,54,43,44,45"
    SIZE = 13
    PARAMS = [
      { version: "L", month: 13, data: DATA, size: SIZE, indices: INDICES },
      { version: "R", month: 14, data: DATA, size: SIZE, indices: INDICES },
      { version: "14", month: 2, data: DATA, size: SIZE, indices: INDICES }
    ]
    def stats(season, team)
      css = ".grid_line_regular"
      @stats = {}
      PARAMS.each do |params|
        params[:year] = season.year
        params[:fangraph_id] = team.fangraph_id
        [0, 1].each do |rost|
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
          elsif [:ab, :bb, :sb, :so, :wrc].include?(key)
            value = slice[index].to_i
          elsif [:slg, :obp, :woba].include?(key)
            value = slice[index].thou_i
          elsif [:ld, :gb, :fb].include?(key)
            value = slice[index].to_f
          end
          [key, value]
        end
        Hash[stat_array]
      end
      return rows
    end

    def build_url(params)
      "http://www.fangraphs.com/leaders.aspx?pos=all&stats=bat&lg=all&qual=0&type=#{params[:data]}&season=#{params[:year]}&month=#{params[:month]}&season1=#{params[:year]}&ind=0&team=#{params[:fangraph_id]}&rost=#{params[:rost]}&age=0&filter=&players=0&page=1_50"
    end
  end
end
