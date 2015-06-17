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

    # crappy initializing

    getCell = lambda do 
        [rand(40),rand(40)+25].asString()
    end 
    
    alive = []
    
    while(alive.size() < 200) do
        cell = getCell.call()
        if (!alive.include?(cell))
            alive << cell
        end
    end

    # crappy initializing is over

    screen.addstr("start")
    screen.getch

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
