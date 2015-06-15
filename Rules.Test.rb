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

    def test_IsNeighbourhoodEntryInAliveList

    end

    def test_IsNeighbourhoodEntryNotInAliveList
        #
    end
    
    def test_IsStayingAlive
    
    end
    
    def test_IsBeBorn
    
    end
    
    def test_IsDying
    
    end

end
