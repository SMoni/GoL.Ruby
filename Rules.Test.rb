require "test/unit"
require "./Rules.rb"

class Suite < Test::Unit::TestCase

    Array.include Rules
    
    def test_InitAliveAndNeighbourhoodLists
        #(new Array(), new Hash())
    end

    def test_IsEntryInBothLists
        
        alive          = [ :entry ]
        neighbourhoods = { :entry => 0 }

        result = [alive, neighbourhoods].validate()

        assert(result.include? :entry) 
    end
    
    def test_IsStayingAlive

        isStayingAliveWithNumberOfNeighbours = [2,3]

        isStayingAlive = lambda do |alive, key, value|
            alive.include?(key) && isStayingAliveWithNumberOfNeighbours.include?(value)
        end

        alive          = [ :toStayAlive ]
        neighbourhoods = { :toStayAlive => 2 }

        result = [alive, neighbourhoods].validateWith(isStayingAlive)

        assert(result.include? :toStayAlive) 
    
    end

    def test_IsDying

        isStayingAliveWithNumberOfNeighbours = [2,3]

        isStayingAlive = lambda do |alive, key, value|
            alive.include?(key) && isStayingAliveWithNumberOfNeighbours.include?(value)
        end

        alive          = [ :toDie ]
        neighbourhoods = { :toDie => 4 }

        result = [alive, neighbourhoods].validateWith(isStayingAlive)

        assert(result.empty?) 
    
    end
    
    def test_IsBeBorn

        isBeingBornWithNumberOfNeighbours = [3]

        isBeingBorn = lambda do |alive, key, value|
            !alive.include?(key) && isBeingBornWithNumberOfNeighbours.include?(value)
        end

        alive          = [ ]
        neighbourhoods = { :toBeBorn => 3 }

        result = [alive, neighbourhoods].validateWith(isBeingBorn)

        assert(result.include? :toBeBorn) 
    
    end

end
