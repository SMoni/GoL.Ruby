module Neighbourhood

    def getNeighbourhood()

        numberOfElements       = self.getNumberOfElements()
        lastIndexOfDimensions  = numberOfElements.count - 1
        offset                 = -1
    
        return lambda do |coordinates|

            result = Array.new(numberOfElements.last)
        
            result.each_with_index do |_, index|

                lastIndexOfCoordinates = coordinates.count - 1 
                indexForDimension      = lastIndexOfDimensions
                innerResult            = Array.new(lastIndexOfDimensions)

                (0..lastIndexOfCoordinates).each do |counter|
                    
                    innerResult[counter] = 0
                    
                    currentDimension  = numberOfElements[indexForDimension]
                    previousDimension = numberOfElements[indexForDimension -= 1]
                    
                    innerResult[counter] += index % currentDimension / previousDimension
                    innerResult[counter] += coordinates[counter] 
                    innerResult[counter] += offset
                    
                end
                
                result[index] = innerResult
                
            end
            
            result.delete(coordinates)
            
            return result
            
        end
    end

    def getNumberOfElements()

        rank      = self.count
        result    = Array.new(rank + 1)
        result[0] = 1

        (1..rank).each do |index|
            result[index] = result[index - 1] * self[rank - index]
        end

        return result
    end

end

