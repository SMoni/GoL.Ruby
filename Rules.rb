module Rules

    def validate()
        alive          = self[0]
        neighbourhoods = self[1]
        
        result = neighbourhoods.select do |entry, neighbours| 
            alive.include? entry
        end     
        
        return result   
    end

    def validateWith(rule)
        alive          = self[0]
        neighbourhoods = self[1]
        
        result = neighbourhoods.select do |key, value| 
            rule.call(alive, key, value)
        end     
        
        return result   
    end


end
