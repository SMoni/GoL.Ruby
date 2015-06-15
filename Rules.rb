module Rules

    def validate()
        alive          = self[0]
        neighbourhoods = self[1]
        
        result = neighbourhoods.select do |entry, neighbours| 
            p entry
            
            alive.include? entry
        end     
        
        return result   
    end

end
