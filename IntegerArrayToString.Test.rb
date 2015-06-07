require "test/unit"
require "./IntegerArrayToString.rb"

class Suite < Test::Unit::TestCase

    Array.include IntegerArrayToString

    def test_GetArrayAsString
    
        randomNumber = Random.new.rand(1..100)
    
        actual   = [randomNumber, randomNumber].asString()
        expected = "#{randomNumber},#{randomNumber}"
        
        assert_equal(expected, actual)
    end
end
