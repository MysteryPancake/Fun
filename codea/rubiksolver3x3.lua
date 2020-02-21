local function makebox(name,x,y,w,h)
    local xw = w/3
    local yh = h/3
    for i = x, x+w-1, xw do
        for j = y, y+h-1, yh do
            table.insert(cube[name],{x=i,y=j,w=xw,h=yh,c=colors[name],o=colors[name]})
        end
    end
end

local function checksolved()
    for _,tbl in pairs(cube) do
        for _,box in ipairs(tbl) do
            if tbl[5].c ~= box.c then return false end
        end
    end
    return true
end

local function checktouch(tbl,touch)
    if touch.x >= tbl.x and touch.x <= tbl.x+tbl.w
    and touch.y >= tbl.y and touch.y <= tbl.y+tbl.h then
    return true end
end

local function twist(tbl,clockwise)
    if clockwise then
        cube[tbl][1].n = cube[tbl][7].c cube[tbl][2].n = cube[tbl][4].c cube[tbl][3].n = cube[tbl][1].c
        cube[tbl][4].n = cube[tbl][8].c cube[tbl][6].n = cube[tbl][2].c cube[tbl][7].n = cube[tbl][9].c
        cube[tbl][8].n = cube[tbl][6].c cube[tbl][9].n = cube[tbl][3].c
    else
        cube[tbl][1].n = cube[tbl][3].c cube[tbl][2].n = cube[tbl][6].c cube[tbl][3].n = cube[tbl][9].c
        cube[tbl][4].n = cube[tbl][2].c cube[tbl][6].n = cube[tbl][8].c cube[tbl][7].n = cube[tbl][1].c
        cube[tbl][8].n = cube[tbl][4].c cube[tbl][9].n = cube[tbl][7].c
    end
end

local function up(clockwise)
    twist("up",clockwise)
    if clockwise then
        cube.left[3].n = cube.front[3].c cube.left[6].n = cube.front[6].c cube.left[9].n = cube.front[9].c
        cube.front[3].n = cube.right[3].c cube.front[6].n = cube.right[6].c cube.front[9].n = cube.right[9].c
        cube.right[3].n = cube.back[3].c cube.right[6].n = cube.back[6].c cube.right[9].n = cube.back[9].c
        cube.back[3].n = cube.left[3].c cube.back[6].n = cube.left[6].c cube.back[9].n = cube.left[9].c
    else
        cube.left[3].n = cube.back[3].c cube.left[6].n = cube.back[6].c cube.left[9].n = cube.back[9].c
        cube.front[3].n = cube.left[3].c cube.front[6].n = cube.left[6].c cube.front[9].n = cube.left[9].c
        cube.right[3].n = cube.front[3].c cube.right[6].n = cube.front[6].c cube.right[9].n = cube.front[9].c
        cube.back[3].n = cube.right[3].c cube.back[6].n = cube.right[6].c cube.back[9].n = cube.right[9].c
    end
end

local function left(clockwise)
    twist("left",clockwise)
    if clockwise then
        cube.up[1].n = cube.back[9].c cube.up[2].n = cube.back[8].c cube.up[3].n = cube.back[7].c
        cube.front[1].n = cube.up[1].c cube.front[2].n = cube.up[2].c cube.front[3].n = cube.up[3].c
        cube.back[9].n = cube.down[1].c cube.back[8].n = cube.down[2].c cube.back[7].n = cube.down[3].c
        cube.down[1].n = cube.front[1].c cube.down[2].n = cube.front[2].c cube.down[3].n = cube.front[3].c
    else
        cube.up[1].n = cube.front[1].c cube.up[2].n = cube.front[2].c cube.up[3].n = cube.front[3].c
        cube.front[1].n = cube.down[1].c cube.front[2].n = cube.down[2].c cube.front[3].n = cube.down[3].c
        cube.back[9].n = cube.up[1].c cube.back[8].n = cube.up[2].c cube.back[7].n = cube.up[3].c
        cube.down[1].n = cube.back[9].c cube.down[2].n = cube.back[8].c cube.down[3].n = cube.back[7].c
    end
end

local function front(clockwise)
    twist("front",clockwise)
    if clockwise then
        cube.up[7].n = cube.left[9].c cube.up[4].n = cube.left[8].c cube.up[1].n = cube.left[7].c
        cube.left[9].n = cube.down[3].c cube.left[8].n = cube.down[6].c cube.left[7].n = cube.down[9].c
        cube.right[1].n = cube.up[7].c cube.right[2].n = cube.up[4].c cube.right[3].n = cube.up[1].c
        cube.down[3].n = cube.right[1].c cube.down[6].n = cube.right[2].c cube.down[9].n = cube.right[3].c
    else
        cube.up[7].n = cube.right[1].c cube.up[4].n = cube.right[2].c cube.up[1].n = cube.right[3].c
        cube.left[9].n = cube.up[7].c cube.left[8].n = cube.up[4].c cube.left[7].n = cube.up[1].c
        cube.right[1].n = cube.down[3].c cube.right[2].n = cube.down[6].c cube.right[3].n = cube.down[9].c
        cube.down[3].n = cube.left[9].c cube.down[6].n = cube.left[8].c cube.down[9].n = cube.left[7].c
    end
end

local function right(clockwise)
    twist("right",clockwise)
    if clockwise then
        cube.up[9].n = cube.front[9].c cube.up[8].n = cube.front[8].c cube.up[7].n = cube.front[7].c
        cube.front[9].n = cube.down[9].c cube.front[8].n = cube.down[8].c cube.front[7].n = cube.down[7].c
        cube.back[1].n = cube.up[9].c cube.back[2].n = cube.up[8].c cube.back[3].n = cube.up[7].c
        cube.down[9].n = cube.back[1].c cube.down[8].n = cube.back[2].c cube.down[7].n = cube.back[3].c
    else
        cube.up[9].n = cube.back[1].c cube.up[8].n = cube.back[2].c cube.up[7].n = cube.back[3].c
        cube.front[9].n = cube.up[9].c cube.front[8].n = cube.up[8].c cube.front[7].n = cube.up[7].c
        cube.back[1].n = cube.down[9].c cube.back[2].n = cube.down[8].c cube.back[3].n = cube.down[7].c
        cube.down[9].n = cube.front[9].c cube.down[8].n = cube.front[8].c cube.down[7].n = cube.front[7].c
    end
end

local function back(clockwise)
    twist("back",clockwise)
    if clockwise then
        cube.up[3].n = cube.right[9].c cube.up[6].n = cube.right[8].c cube.up[9].n = cube.right[7].c
        cube.left[1].n = cube.up[3].c cube.left[2].n = cube.up[6].c cube.left[3].n = cube.up[9].c
        cube.right[9].n = cube.down[7].c cube.right[8].n = cube.down[4].c cube.right[7].n = cube.down[1].c
        cube.down[7].n = cube.left[1].c cube.down[4].n = cube.left[2].c cube.down[1].n = cube.left[3].c
    else
        cube.up[3].n = cube.left[1].c cube.up[6].n = cube.left[2].c cube.up[9].n = cube.left[3].c
        cube.left[1].n = cube.down[7].c cube.left[2].n = cube.down[4].c cube.left[3].n = cube.down[1].c
        cube.right[9].n = cube.up[3].c cube.right[8].n = cube.up[6].c cube.right[7].n = cube.up[9].c
        cube.down[7].n = cube.right[9].c cube.down[4].n = cube.right[8].c cube.down[1].n = cube.right[7].c
    end
end

local function down(clockwise)
    twist("down",clockwise)
    if clockwise then
        cube.left[7].n = cube.back[7].c cube.left[4].n = cube.back[4].c cube.left[1].n = cube.back[1].c
        cube.front[7].n = cube.left[7].c cube.front[4].n = cube.left[4].c cube.front[1].n = cube.left[1].c
        cube.right[7].n = cube.front[7].c cube.right[4].n = cube.front[4].c cube.right[1].n = cube.front[1].c
        cube.back[7].n = cube.right[7].c cube.back[4].n = cube.right[4].c cube.back[1].n = cube.right[1].c
    else
        cube.left[7].n = cube.front[7].c cube.left[4].n = cube.front[4].c cube.left[1].n = cube.front[1].c
        cube.front[7].n = cube.right[7].c cube.front[4].n = cube.right[4].c cube.front[1].n = cube.right[1].c
        cube.right[7].n = cube.back[7].c cube.right[4].n = cube.back[4].c cube.right[1].n = cube.back[1].c
        cube.back[7].n = cube.left[7].c cube.back[4].n = cube.left[4].c cube.back[1].n = cube.left[1].c
    end
end

function setup()
    displayMode(FULLSCREEN)
    font("HelveticaNeue-Light")
    fontSize(75)
    solves = 100000
    limit = 50
    solving = false
    solved = false
    scroll = 0
    steps = {}
    painter = {}
    selected = 6
    cube = {up = {}, left = {}, front = {}, right = {}, back = {}, down = {}}
    colors = {
    up = color(255,255,255),
    left = color(0,255,0),
    front = color(255,0,0),
    right = color(0,0,255),
    back = color(255,165,0),
    down = color(255,255,0)
    }
    names = {"Up","Left","Front","Right","Back","Down"}
    twists = {up,left,front,right,back,down}
    local x = WIDTH/4
    local y = HEIGHT/3
    makebox("up",x,HEIGHT-y,x,y)
    makebox("left",0,y,x,y)
    makebox("front",x,y,x,y)
    makebox("right",x*2,y,x,y)
    makebox("back",x*3,y,x,y)
    makebox("down",x,0,x,y)
    local i = WIDTH-65
    for _,v in pairs(colors) do
        table.insert(painter,{x=i,y=HEIGHT-65,w=60,h=60,c=v})
        i = i-70
    end
end

function draw()
    background(0)
    if solved then
        textMode(CENTER)
        textAlign(CENTER)
        local i = scroll
        for k,v in ipairs(steps) do
            local name = names[v[1]]
            local dir = v[2] and "clockwise" or "anticlockwise"
            fill(cube[string.lower(name)][5].c)
            text(name..": "..dir,WIDTH/2,HEIGHT/2+i)
            local w,h = textSize(name..": "..dir)
            i = i-h
        end
    else
        for _,tbl in pairs(cube) do
            for _,box in ipairs(tbl) do
                fill(box.c)
                rect(box.x+5,box.y+5,box.w-10,box.h-10)
            end
        end
        if solving then
            local prevtwist
            local prevdir
            for _ = 1, solves do
                if solving then
                    local twist = math.random(#twists)
                    local dir = math.random(2) == 1
                    if twist == prevtwist and dir ~= prevdir then
                        dir = not dir
                    end
                    twists[twist](dir)
                    table.insert(steps,{twist,dir})
                    prevtwist = twist
                    prevdir = dir
                    for _,tbl in pairs(cube) do
                        for _,box in ipairs(tbl) do
                            if box.n then
                                box.c = box.n
                                box.n = nil
                            end
                        end
                    end
                    if checksolved() then
                        solving = false
                        solved = true
                    end
                    if #steps > limit then
                        for _,tbl in pairs(cube) do
                            for _,box in ipairs(tbl) do
                                box.c = box.o
                            end
                        end
                        steps = {}
                    end
                end
            end
        else
            for k,v in ipairs(painter) do
                fill(v.c)
                if selected == k then
                    rect(v.x+10,v.y+10,v.w-20,v.h-20)
                else
                    rect(v.x,v.y,v.w,v.h)
                end
            end
            fill(255)
            textMode(CORNER)
            local strw,strh = textSize("Begin")
            text("Begin",WIDTH-strw-25,25)
        end
    end
end

function touched(touch)
    if solved then
        scroll = scroll+touch.deltaY
    else
        if not solving then
            for _,tbl in pairs(cube) do
                for _,box in ipairs(tbl) do
                    if checktouch(box,touch) then
                        box.o = painter[selected].c
                        box.c = painter[selected].c
                    end
                end
            end
            for k,box in ipairs(painter) do
                if checktouch(box,touch) then
                    selected = k
                end
            end
            if touch.x > WIDTH*3/4 and touch.y < HEIGHT/5 then
                solving = true
            end
        end
    end
end