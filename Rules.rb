module Rules
 
    def validate
        alive          = self[0]
        neighbourhoods = self[1]

        neighboursForStayingAlive  = [2, 3]
        neighboursForBeingBorn     = [3]

        isInAlive = lambda { |anArray| 
            lambda { |thisEntry| anArray.include?(thisEntry) } 
        }.call(alive)
        
        stayingAlive = lambda { |coordinates, neighbours|  
            isInAlive.call(coordinates) && neighboursForStayingAlive.include?(neighbours) 
        } 
        
        willBeBorn = lambda { |coordinates, neighbours| 
            !isInAlive.call(coordinates) && neighboursForBeingBorn.include?(neighbours)
        }

        rules = [
            stayingAlive,
            willBeBorn
        ]
        
        neighbourhoods.select do |key, value| 
            rules.any? { |rule| rule.call(key, value) }
        end     
    end

end
