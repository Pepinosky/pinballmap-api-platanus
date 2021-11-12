require 'httparty'
require 'pp'
require 'hash_dig_and_collect'
class PinballMap
    include HTTParty
    base_uri 'https://pinballmap.com/api/v1'
    format :json
  
    def regions
        self.class.get('/regions')
    end
    def location_and_machine_counts(region_name)
        parameters = {query: {region_name: region_name}}
        self.class.get("/regions/location_and_machine_counts", parameters)
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
    
    def get_locations_machines(region_names)
        locations_machines = PinballMap.new
        total_machines = 0
        region_names.values.each do |region_name|         
              total_machines += locations_machines.location_and_machine_counts(region_name)["num_lmxes"]
        end
        return total_machines
    end

    def get_locations_with_more_machines(region_names)
        locations= PinballMap.new
        location_with_more_machines_count= 0
        location_with_more_machines_name= nil
        count= 0
        
        region_names.values.each do |region_name|         
            location= locations.locations(region_name)["locations"]       
            location.each do |l|
              if l["num_machines"] >= location_with_more_machines_count 
                location_with_more_machines_count= l["num_machines"]
                location_with_more_machines_name = l["name"]
              end 
            end  
        end
        return location_with_more_machines_name
          
    end
    
    def get_locations_with_less_machines(region_names)
        locations= PinballMap.new
        location_with_less_machines_count= 0
        location_with_less_machines_name= nil
        
        
        region_names.values.each do |region_name|         
            location= locations.locations(region_name)["locations"]       
            location.each do |l|
                location_with_less_machines_count= l["num_machines"]
              if l["num_machines"] <= location_with_less_machines_count 
                location_with_less_machines_count= l["num_machines"]
                location_with_less_machines_name = l["name"]
              end 
            end  
        end
        return location_with_less_machines_name
          
    end  
    

end



  region = Regions.new
  locations= Locations.new
  region_names = region.get_first_n_regions_name(1)
  all_locations = locations.get_locations_from_region(region_names)
  total_machines= locations.get_locations_machines(region_names)
  locations_total = locations.get_locations_number(all_locations)
  average_machines = total_machines/locations_total
  
  location_with_more_machines = locations.get_locations_with_more_machines(region_names)
  location_with_less_machines = locations.get_locations_with_less_machines(region_names)

  
   pp "estadísticas:"
   pp "total de locations: #{locations_total}" 
   pp "cantidad de maquinas: #{total_machines}"
   pp "promedio de maquinas: #{average_machines.to_f}"
   pp "ubicacion con mayor cantidad de maquinas: #{location_with_more_machines}"
   pp "ubicacion con menor cantidad de maquinas: #{location_with_less_machines}"

 


  

  
   
  
