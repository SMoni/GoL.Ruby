require "ncurses"

require "./Neighbourhood.rb"
require "./Rules.rb"
require "./Tools.rb"

Array.include  Neighbourhood
Array.include  Rules
Array.include  IntegerArrayToString
String.include StringToIntegerArray

module Doing

    def refresh()

        neighbourhoodFor = [3,3].getNeighbourhood()

        neighbourhoods = Hash.new { |hash, key| hash[key] = 0 }

        self.each do |item|
            neighbourhoodFor.call(item.asArray()).each do |neighbour|
                neighbourhoods[neighbour.asString()] += 1
            end
        end

        return [self, neighbourhoods].validate().keys
     
    end

end

Array.include Doing

def initializeScreen
    Ncurses.initscr
    Ncurses.noecho
    Ncurses.nonl
    Ncurses.cbreak
    Ncurses.noecho
    Ncurses.nonl
    Ncurses.stdscr.intrflush(false)
    Ncurses.stdscr.keypad(true)
    Ncurses.curs_set(0)
    return Ncurses.stdscr
end

def finalizeScreen
    Ncurses.echo
    Ncurses.nocbreak
    Ncurses.nl
    Ncurses.endwin
end

begin
    screen = initializeScreen()

    screen.addstr("start")
    screen.getch
 
    alive = [ 
        [15,35],
        [16,35],
        [17,35],
        [22,42], 
        [22,43],
        [22,44],
        [22,41],
        [24,43],
        [23,44],
        [22,45],
        [23,43],
        [24,45]
    ].map(&:asString)

    (1..400).each do
        
        alive = alive.refresh()
        
        screen.clear
        
        alive.each do |coordinate|
            asArray = coordinate.asArray()
            screen.mvaddstr(asArray[0], asArray[1], "X")
        end
        
        screen.refresh
        
    end

    screen.mvaddstr(20, 1, "done")
    screen.getch
        
ensure
    finalizeScreen()
end
