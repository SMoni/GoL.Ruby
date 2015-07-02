require "ncurses"

require "./Neighbourhood.rb"
require "./Rules.rb"
require "./Tools.rb"
require "./Init.rb"

module TalkToMe
    def sayStart
        self.mvaddstr(19, 1, "-------")
        self.mvaddstr(20, 1, "|start|")
        self.mvaddstr(21, 1, "-------")
        self.getch
    end

    def sayDone
        self.mvaddstr(19, 1, "------")
        self.mvaddstr(20, 1, "|done|")
        self.mvaddstr(21, 1, "------")
        self.getch
    end

end

Array.include  Neighbourhood
Array.include  Rules
Array.include  IntegerArrayToString
String.include StringToIntegerArray
Object.include TalkToMe

@neighbourhoodFor = [3,3].getNeighbourhood()

def refreshThis(array_)

    neighbourhoods = Hash.new { |hash, key| hash[key] = 0 }

    array_.each do |item|
        @neighbourhoodFor.call(item.asArray()).each do |neighbour|
            neighbourhoods[neighbour.asString()] += 1
        end
    end

    return [array_, neighbourhoods].validate().keys
 
end

begin
    screen = initializeScreen()
    screen.sayStart

    alive =  (0..200)
        .map { [rand(40),rand(40)+25].asString() }
        .uniq()

    drawCell = lambda do |coordinate|
        asArray = coordinate.asArray()
        screen.mvaddstr(asArray[0], asArray[1], "X")
    end

    (0..400).each do
        
        alive = refreshThis(alive)
        
        screen.clear
        
        alive.each{ |coordinate| drawCell.call(coordinate) }
        
        screen.refresh
        
    end
        
    screen.sayDone
        
ensure
    finalizeScreen()
end
