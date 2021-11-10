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
                region_names["region_name_#{i}"]= "#{region["name"]}"
                if i >= n
                return region_names
                end
              i= i+1    
             end    
      
    end
end

class Locations
    def get_locations_from_region(region_names)
        locations= PinballMap.new
        region_names.values.each do |region_name|         
          location= locations.locations(region_name)["locations"]
            location.each do |l|
                pp l
            end    
        end

    end
end

  region_name = Regions.new
  locations= Locations.new

  pp region_name.get_first_n_regions_name(1)
  locations.get_locations_from_region(region_name.get_first_n_regions_name(2)) 
 



  

  
   
  
