require "test/unit"
require "./Elements.rb"

class Suite < Test::Unit::TestCase

    Array.include Elements

    def test_GetNumberOfElements
        
        expected = [1,3,6,24]
        actual   = [3,2,4].getNumberOfElements()
        
        assert_equal(expected, actual)
    end

end
