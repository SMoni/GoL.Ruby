module Rules
 
    def validate()
        alive          = self[0]
        neighbourhoods = self[1]

        rules = [
            lambda { |alive, key, value|  alive.include?(key) && [2,3].include?(value) },
            lambda { |alive, key, value| !alive.include?(key) && [3]  .include?(value) }
        ]
        
        result = neighbourhoods.select do |key, value| 
            rules.any? { |rule| rule.call(alive, key, value) }
        end     
        
        return result   
    end


end
