function MakeColor()
    return color(math.random(255),math.random(255),math.random(255))
end

function setup()
    displayMode(FULLSCREEN)
    backingMode(RETAINED)
    math.randomseed(os.time())
    strokeWidth(3)
    lineCapMode(SQUARE)
    trails = {}
    speed = 20
    for i = 0,150 do
        speed = math.random(10)
        trails[i] = { sx = WIDTH/2, cx = WIDTH/2, sy = HEIGHT/2, cy = HEIGHT/2, movex = 0, movey = PosOrNeg(speed), c = MakeColor() }
    end
end

function math.Clamp( int, low, high )
    if (int < low) then return low end
    if (int > high) then return high end
    return int
end

function Either(a,b,c)
    return a and b or c
end

function NewTblCollisionKey(t,bool)
    t.sx = t.cx
    t.cx = math.Clamp(t.cx,0,WIDTH)
    t.sy = t.cy
    t.cy = math.Clamp(t.cy,0,HEIGHT)
    t.movex = Either(bool,t.movex,-t.movex)
    t.movey = Either(bool,-t.movey,t.movey)
end

function CheckCollisions(tab)
    if tab.cy > HEIGHT or tab.cy < 0 then
        NewTblCollisionKey(tab,true)
    elseif tab.cx > WIDTH or tab.cx < 0 then
        NewTblCollisionKey(tab,false)
    end
end

function PosOrNeg(i)
    return math.random() > 0.5 and i or -i
end

function RandomizeDirection(tab)
    local n1, n2 = 0,0
    if math.random() > 0.5 then
        n1 = PosOrNeg(speed)
    else
        n2 = PosOrNeg(speed)
    end
    tab.sx = tab.cx
    tab.cx = math.Clamp(tab.cx,0,WIDTH)
    tab.sy = tab.cy
    tab.cy = math.Clamp(tab.cy,0,HEIGHT)
    tab.movex = n1
    tab.movey = n2
end

function draw()
    for k,tab in ipairs(trails) do
        tab.cx = tab.cx + tab.movex
        tab.cy = tab.cy + tab.movey
        CheckCollisions(tab)
        if math.random(20) == 20 then
            RandomizeDirection(tab)
        end
        stroke(tab.c)
        line(tab.sx,tab.sy,tab.cx,tab.cy)
    end
end