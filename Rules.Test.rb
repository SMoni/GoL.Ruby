require "test/unit"
require "./Rules.rb"

class Suite < Test::Unit::TestCase

    Array.include Rules
    
    def test_IsStayingAlive

        alive          = [ :toStayAlive ]
        neighbourhoods = { :toStayAlive => 2 }

        result = [alive, neighbourhoods].validate()

        assert(result.include? :toStayAlive) 
    
    end

    def test_IsDying

        alive          = [ :toDie ]
        neighbourhoods = { :toDie => 4 }

        result = [alive, neighbourhoods].validate()

        assert(result.empty?) 
    
    end
    
    def test_IsBeBorn

        alive          = [ ]
        neighbourhoods = { :toBeBorn => 3 }

        result = [alive, neighbourhoods].validate()

        assert(result.include? :toBeBorn) 
    
    end

    def test_IsUsingTwoRules

        alive          = [ :toStayAlive, :toDie ]
        neighbourhoods = { :toStayAlive => 3, :toDie => 4, :toBeBorn => 3 }

        result = [alive, neighbourhoods].validate()

        assert(result.include?(:toStayAlive), "not alive") 
        assert(result.include?(:toBeBorn),    "not born") 
        assert(!(result.include?(:toDie)),    "not dead") 
    
    end

end
