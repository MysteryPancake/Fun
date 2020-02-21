local function makeSide(name,x,y,w,h)
    local xw = w/2
    local yh = h/2
    for i = x, x+w-1, xw do
        for j = y, y+h-1, yh do
            table.insert(cube[name],{x=i,y=j,w=xw,h=yh,c=colors[name],o=colors[name]})
        end
    end
end

local function makePainter(x,y,w,h)
    for _,color in pairs(colors) do
        table.insert(painter,{x=x,y=y,w=w,h=h,c=color})
        x = x-w
    end
end

local function isSolved()
    for name,side in pairs(cube) do
        for _,box in ipairs(side) do
            if box.c ~= colors[name] then return false end
        end
    end
    return true
end

local function isTouched(box,touch)
    if touch.x >= box.x and touch.x <= box.x+box.w and touch.y >= box.y and touch.y <= box.y+box.h then
        return true
    end
    return false
end

local function twist(side,clockwise)
    if clockwise then
        cube[side][1].n = cube[side][3].c cube[side][2].n = cube[side][1].c
        cube[side][3].n = cube[side][4].c cube[side][4].n = cube[side][2].c
    else
        cube[side][1].n = cube[side][2].c cube[side][2].n = cube[side][4].c
        cube[side][3].n = cube[side][1].c cube[side][4].n = cube[side][3].c
    end
end

local function up(clockwise)
    twist("up",clockwise)
    if clockwise then
        cube.left[2].n = cube.front[2].c cube.left[4].n = cube.front[4].c
        cube.front[2].n = cube.right[2].c cube.front[4].n = cube.right[4].c
        cube.right[2].n = cube.back[2].c cube.right[4].n = cube.back[4].c
        cube.back[2].n = cube.left[2].c cube.back[4].n = cube.left[4].c
    else
        cube.left[2].n = cube.back[2].c cube.left[4].n = cube.back[4].c
        cube.front[2].n = cube.left[2].c cube.front[4].n = cube.left[4].c
        cube.right[2].n = cube.front[2].c cube.right[4].n = cube.front[4].c
        cube.back[2].n = cube.right[2].c cube.back[4].n = cube.right[4].c
    end
end

local function left(clockwise)
    twist("left",clockwise)
    if clockwise then
        cube.up[1].n = cube.back[4].c cube.up[2].n = cube.back[3].c
        cube.front[1].n = cube.up[1].c cube.front[2].n = cube.up[2].c
        cube.back[4].n = cube.down[1].c cube.back[3].n = cube.down[2].c
        cube.down[1].n = cube.front[1].c cube.down[2].n = cube.front[2].c
    else
        cube.up[1].n = cube.front[1].c cube.up[2].n = cube.front[2].c
        cube.front[1].n = cube.down[1].c cube.front[2].n = cube.down[2].c
        cube.back[4].n = cube.up[1].c cube.back[3].n = cube.up[2].c
        cube.down[1].n = cube.back[4].c cube.down[2].n = cube.back[3].c
    end
end

local function front(clockwise)
    twist("front",clockwise)
    if clockwise then
        cube.up[3].n = cube.left[4].c cube.up[1].n = cube.left[3].c
        cube.left[4].n = cube.down[2].c cube.left[3].n = cube.down[4].c
        cube.right[1].n = cube.up[3].c cube.right[2].n = cube.up[1].c
        cube.down[2].n = cube.right[1].c cube.down[4].n = cube.right[2].c
    else
        cube.up[3].n = cube.right[1].c cube.up[1].n = cube.right[2].c
        cube.left[4].n = cube.up[3].c cube.left[3].n = cube.up[1].c
        cube.right[1].n = cube.down[2].c cube.right[2].n = cube.down[4].c
        cube.down[2].n = cube.left[4].c cube.down[4].n = cube.left[3].c
    end
end

local function right(clockwise)
    twist("right",clockwise)
    if clockwise then
        cube.up[4].n = cube.front[4].c cube.up[3].n = cube.front[3].c
        cube.front[4].n = cube.down[4].c cube.front[3].n = cube.down[3].c
        cube.back[1].n = cube.up[4].c cube.back[2].n = cube.up[3].c
        cube.down[4].n = cube.back[1].c cube.down[3].n = cube.back[2].c
    else
        cube.up[4].n = cube.back[1].c cube.up[3].n = cube.back[2].c
        cube.front[4].n = cube.up[4].c cube.front[3].n = cube.up[3].c
        cube.back[1].n = cube.down[4].c cube.back[2].n = cube.down[3].c
        cube.down[4].n = cube.front[4].c cube.down[3].n = cube.front[3].c
    end
end

local function back(clockwise)
    twist("back",clockwise)
    if clockwise then
        cube.up[2].n = cube.right[4].c cube.up[4].n = cube.right[3].c
        cube.left[1].n = cube.up[2].c cube.left[2].n = cube.up[4].c
        cube.right[4].n = cube.down[3].c cube.right[3].n = cube.down[1].c
        cube.down[3].n = cube.left[1].c cube.down[1].n = cube.left[2].c
    else
        cube.up[2].n = cube.left[1].c cube.up[4].n = cube.left[2].c
        cube.left[1].n = cube.down[3].c cube.left[2].n = cube.down[1].c
        cube.right[4].n = cube.up[2].c cube.right[3].n = cube.up[4].c
        cube.down[3].n = cube.right[4].c cube.down[1].n = cube.right[3].c
    end
end

local function down(clockwise)
    twist("down",clockwise)
    if clockwise then
        cube.left[3].n = cube.back[3].c cube.left[1].n = cube.back[1].c
        cube.front[3].n = cube.left[3].c cube.front[1].n = cube.left[1].c
        cube.right[3].n = cube.front[3].c cube.right[1].n = cube.front[1].c
        cube.back[3].n = cube.right[3].c cube.back[1].n = cube.right[1].c
    else
        cube.left[3].n = cube.front[3].c cube.left[1].n = cube.front[1].c
        cube.front[3].n = cube.right[3].c cube.front[1].n = cube.right[1].c
        cube.right[3].n = cube.back[3].c cube.right[1].n = cube.back[1].c
        cube.back[3].n = cube.left[3].c cube.back[1].n = cube.left[1].c
    end
end

function setup()
    displayMode(FULLSCREEN)
    supportedOrientations(LANDSCAPE_ANY)
    font("HelveticaNeue-Light")
    fontSize(75)
    textAlign(CENTER)
    solving = false
    solved = false
    guesses = 100000
    limit = 50
    scroll = 0
    steps = {}
    painter = {}
    selected = 6
    cube = {up = {}, left = {}, front = {}, right = {}, back = {}, down = {}}
    names = {"Up","Left","Front","Right","Back","Down"}
    twists = {up,left,front,right,back,down}
    colors = {
    up = color(255,255,255),
    left = color(0,255,0),
    front = color(255,0,0),
    right = color(0,0,255),
    back = color(255,165,0),
    down = color(255,255,0)
    }
    local w = WIDTH/4
    local h = HEIGHT/3
    makeSide("up",w,HEIGHT-h,w,h)
    makeSide("left",0,h,w,h)
    makeSide("front",w,h,w,h)
    makeSide("right",w*2,h,w,h)
    makeSide("back",w*3,h,w,h)
    makeSide("down",w,0,w,h)
    makePainter(WIDTH-w/3.5,HEIGHT-h/3.5,w/3.5,h/3.5)
end

function draw()
    background(0)
    if solved then
        textMode(CENTER)
        local i = scroll
        for _,step in ipairs(steps) do
            local name = names[step.func]
            local dir = step.dir and "clockwise" or "anticlockwise"
            fill(colors[string.lower(name)])
            text(name..": "..dir,WIDTH/2,HEIGHT/2+i)
            local _,h = textSize(name..": "..dir)
            i = i-h
        end
    else
        for _,side in pairs(cube) do
            for _,box in ipairs(side) do
                fill(box.c)
                rect(box.x+5,box.y+5,box.w-10,box.h-10)
            end
        end
        if solving then
            local prevtwist
            local prevdir
            for _ = 1, guesses do
                if solving then
                    local twist = math.random(#twists)
                    local dir = math.random() > 0.5
                    if twist == prevtwist and dir ~= prevdir then
                        dir = not dir
                    end
                    twists[twist](dir)
                    table.insert(steps,{func=twist,dir=dir})
                    prevtwist = twist
                    prevdir = dir
                    for _,side in pairs(cube) do
                        for _,box in ipairs(side) do
                            if box.n then
                                box.c = box.n
                                box.n = nil
                            end
                        end
                    end
                    if isSolved() then
                        solving = false
                        solved = true
                        return
                    end
                    if #steps > limit then
                        for _,side in pairs(cube) do
                            for _,box in ipairs(side) do
                                box.c = box.o
                            end
                        end
                        steps = {}
                    end
                end
            end
        else
            for k,box in ipairs(painter) do
                fill(box.c)
                if selected == k then
                    rect(box.x+20,box.y+20,box.w-40,box.h-40)
                else
                    rect(box.x+5,box.y+5,box.w-10,box.h-10)
                end
            end
            fill(255)
            textMode(CORNER)
            text("Begin",WIDTH-textSize("Begin")-20,20)
        end
    end
end

function touched(touch)
    if solved then
        scroll = scroll+touch.deltaY
    elseif not solving then
        for _,side in pairs(cube) do
            for _,box in ipairs(side) do
                if isTouched(box,touch) then
                    box.c = painter[selected].c
                    box.o = painter[selected].c
                    return
                end
            end
        end
        for k,box in ipairs(painter) do
            if isTouched(box,touch) then
                selected = k
                return
            end
        end
        if touch.x > WIDTH*3/4 and touch.y < HEIGHT/5 then
            solving = true
        end
    end
end