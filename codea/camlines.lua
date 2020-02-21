function setup()
    displayMode(FULLSCREEN)
    backingMode(RETAINED)
    font("AppleColorEmoji")
    index = 1
    detail = 5
    speed = 10
    drawit = false
    bg = false
    str = false
end

function draw()
    if drawit then
        if bg then
            background(0)
            bg = false
        end
        for _ = 1,detail*speed do
            local ind = tbl[index]
            if ind then
                fill(ind.c)
                if str then
                    fontSize(detail*math.random(2,5))
                    text("👌🏻",ind.x,ind.y)
                else
                    ellipse(ind.x,ind.y,math.random(5,20),math.random(5,20))
                end
                index = index + 1
            end
        end
    else
        background(0)
        sprite(CAMERA,WIDTH/2,HEIGHT/2,math.min(spriteSize(CAMERA),WIDTH))
    end
end

local function sort(x,y)
    local sum1 = x.c.r+x.c.g+x.c.b
    local sum2 = y.c.r+y.c.g+y.c.b
    return sum1 > sum2
end

function touched()
    local pic = image(CAMERA)
    local width, height = pic.width, pic.height
    tbl = {}
    for i = 1, width, detail do
        for j = 1, height, detail do
            table.insert(tbl,{x=i,y=j,c=color(pic:get(i,j))})
        end
    end
    table.sort(tbl,sort)
    drawit = true
    bg = true
end
