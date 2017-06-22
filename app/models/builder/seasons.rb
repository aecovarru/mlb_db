module Builder
 module Seasons
   extend self
   def create(years)
     Teams.create
     years.each do |year|
       season = Season.find_or_create_by(year: year)
       if season.teams.empty?
         teams = Teams.teams(season.year)
         teams.each { |team| season.teams << team }
       end
     end
   end
 end
end
