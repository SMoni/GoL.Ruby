require "ncurses"

require "./Neighbourhood.rb"

Array.include Neighbourhood

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

@stayAlive        = [2, 3]
@born             = [3]
@neighbourhoodFor = [3,3].getNeighbourhood()

def iterateThrough(alive)

    neighbourhoods = Hash.new { |hash, key| hash[key] = 0 }

    alive.each do |item|
        @neighbourhoodFor.call(item).each do |neighbour|
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
        [15,25],
        [16,25],
        [17,25],
        [22,32], 
        [22,33],
        [22,34],
        [22,31],
        [24,33],
        [23,34],
        [22,35],
        [23,33],
        [24,35]
    ]

    (1..400).each do
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
