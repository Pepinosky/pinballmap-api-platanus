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
        i=1
        all_locations= Hash.new
        region_names.values.each do |region_name|         
          location= locations.locations(region_name)["locations"]       
             location.each do |l|
                all_locations["location_#{i}"]= l
                i = i + 1
             end    
        end
        #locations_total = all_locations.legnth - 1
        return all_locations
    end

    def get_locations_number(locations)
        return locations.length
    end    
 
end


class Machines
    def get_machine_total
    end    
end    

  region_name = Regions.new
  locations= Locations.new

  all_locations = locations.get_locations_from_region(region_name.get_first_n_regions_name(1))
  locations_total = locations.get_locations_number(all_locations)
  
  pp all_locations
  pp "cantidad de ubicaciones: #{locations_total}"


  pp "promedio de maquinas: #"

 # total_machine = 0
#     regions.each do |region|
#         locations= pinball_api.locations(region_name)
#           location= locations["locations"]
        
#           location.each do |l|
#               total_machine = total_machine + l["num_machines"]
            
#          end
#      end



  

  
   
  
