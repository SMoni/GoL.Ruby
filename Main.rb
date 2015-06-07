require "ncurses"

require "./Neighbourhood.rb"
require "./StringToIntegerArray.rb"
require "./IntegerArrayToString.rb"

Array.include Neighbourhood

module Drawing

    def drawBorder()
        self.clear()
        self.border(*([0]*8)) # calls WINDOW#border(0, 0, 0, 0, 0, 0, 0, 0)
        self.move(3,3)
        self.addstr("Press a key to continue")
        self.getch()
    end

end

def initializeScreen

    Ncurses.initscr
    Ncurses.noecho           # turn off input echoing
    Ncurses.nonl             # turn off newline translation
    Ncurses.cbreak           # provide unbuffered input
    Ncurses.noecho           # turn off input echoing
    Ncurses.nonl             # turn off newline translation
    Ncurses.stdscr.intrflush(false) # turn off flush-on-interrupt
    Ncurses.stdscr.keypad(true)     # turn on keypad mode


    return Ncurses.stdscr

end

def finalizeScreen
    Ncurses.echo
    Ncurses.nocbreak
    Ncurses.nl
    Ncurses.endwin
end

@stayAlive        = [2, 3]
@born             = [3]
@neighbourhoodFor = [3,3].getNeighbourhood()

def iterateThrough(alive)

    neighbourhoods = Hash.new

    alive.each do |item|
        neighbourhood = @neighbourhoodFor.call(item)

        neighbourhood.each do |neighbour|
            if neighbourhoods[neighbour] == nil
                neighbourhoods[neighbour] = 0
            end
            
            neighbourhoods[neighbour] += 1
        end
        
    end

    toStayAlive = neighbourhoods.select do |coordinates, neigbhours| 
        alive.include?(coordinates) && @stayAlive.include?(neigbhours)
    end

    toBeBorn = neighbourhoods.select do |coordinates, neigbhours| 
        !alive.include?(coordinates) && @born.include?(neigbhours)
    end

    return toStayAlive.keys | toBeBorn.keys 

end

begin

    Object.include Drawing

    screen = initializeScreen()

    screen.addstr("start")

    screen.getch
 
    alive = [ 
        [12,12], 
        [12,13],
        [12,14],
        [12,11],
        [14,13],
        [13,14],
        [12,15],
        [13,13],
        [5,5],
        [6,5],
        [7,5]
    ]

    (1..200).each do
        alive = iterateThrough(alive)
        
        screen.clear
        
        alive.each do |coordinate|
            screen.mvaddstr(coordinate[0], coordinate[1], "X")
        end
        
        screen.refresh
        
    end

    screen.mvaddstr(20, 1, "done")

    screen.getch
        
ensure
    finalizeScreen()
end


