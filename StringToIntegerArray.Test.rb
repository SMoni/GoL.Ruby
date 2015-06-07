require "test/unit"
require "./StringToIntegerArray.rb"

class Suite < Test::Unit::TestCase

    String.include StringToIntegerArray

    def test_GetStringAsArray
    
        randomNumber = Random.new.rand(1..100)
    
        actual   = "#{randomNumber},#{randomNumber}".asArray()
        expected = [randomNumber,randomNumber]
        
        assert_equal(expected, actual)
    end
end
