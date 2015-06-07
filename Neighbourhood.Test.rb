require "test/unit"
require "./Neighbourhood.rb"

class Suite < Test::Unit::TestCase

    Array.include Neighbourhood

    def test_GetSimpleMooreNeighbourhood
    
        neighbourhoodFor = [3,3].getNeighbourhood()
    
        actual = neighbourhoodFor.call([1,1])
    
        expected = [
            [0,0], [0,1], [0,2],
            [1,0],        [1,2], 
            [2,0], [2,1], [2,2]
        ]
    
        assert_equal(expected, actual)
    end

    def test_GetRandomMooreNeighbourhood
        
        neighbourhoodFor = [3,3].getNeighbourhood()
        
        centerX = Random.new.rand(1..100)
        centerY = Random.new.rand(1..100)
        
        coordinates = [centerX,centerY]
        
        actual   = neighbourhoodFor.call(coordinates)
        expected = [
            [centerX-1,centerY-1], [centerX-1,centerY], [centerX-1,centerY+1],
            [centerX,centerY-1],                        [centerX,centerY+1], 
            [centerX+1,centerY-1], [centerX+1,centerY], [centerX+1,centerY+1]
        ]

        assert_equal(expected, actual)
    end

end

