require "ncurses"

require "./Neighbourhood.rb"

Array.include Neighbourhood

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
            
            #I don't like that...
            if neighbourhoods[neighbour] == nil
                neighbourhoods[neighbour] = 0
            end
            
            neighbourhoods[neighbour] += 1
        end
        
    end

    toStayAlive = neighbourhoods.select do |coordinates, neighbours| 
        alive.include?(coordinates) && @stayAlive.include?(neighbours)
    end

    toBeBorn = neighbourhoods.select do |coordinates, neighbours| 
        !alive.include?(coordinates) && @born.include?(neighbours)
    end

    return toStayAlive.keys | toBeBorn.keys 

end

begin
    screen = initializeScreen()

    screen.addstr("start")
    screen.getch
 
    alive = [ 
        [5,5],
        [6,5],
        [7,5],
        [12,12], 
        [12,13],
        [12,14],
        [12,11],
        [14,13],
        [13,14],
        [12,15],
        [13,13],
        [14,15]
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


