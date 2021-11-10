require 'httparty'
require 'pp'
class PinballMap
    include HTTParty
    base_uri 'https://pinballmap.com/api/v1'
    format :json
  
    def regions
        self.class.get('/regions')
    end

    def locations(region_name)
        self.class.get("/region/#{region_name}/locations")
    end
end

class Regions 
    def get_first_n_regions_name(n)
             i=0
             n= n - 1
             pinball_api = PinballMap.new
             region_names= Hash.new
             regions= pinball_api.regions["regions"]
             regions.each do |region|
             region_names["region_names"]= {region_name: region["name"]}
                if i >= n
                return region_names
                end
              i= i+1    
             end    
      
    end
end

class Locations
    def get_locations_from_region(region_name)
        locations= PinballMap.new
       pp locations.locations(region_name)
        # region_name.each do |location|
        #     locations          
        # end

    end
end

  region_name = Regions.new
#   locations= Locations.new
#   locations.get_locations_by_region( region_name.get_first_n_regions_name(2))
  rm= region_name.get_first_n_regions_name(2)
  pp rm
  

  
    # pinball_api = PinballMap.new
    # regions= pinball_api.regions["regions"]
    # regions.each do |region|
    #  pp region["name"]
    #  end
#    region_name = regions[0]["name"]
#    pp region_name
 
#   region_names = Array.new(regions.length.to_i)
# total_machine = 0
#     regions.each do |region|
#         locations= pinball_api.locations(region_name)
#           location= locations["locations"]
        
#           location.each do |l|
#               total_machine = total_machine + l["num_machines"]
            
#          end
#      end
   # pp location.length
    
        
    #    pp locations["locations"][0]
    
    #  end

#   pp region_names



  

  
   
  
