local function createRects(gridsizex, gridsizey)
    local rects = {}
    for i = 1, gridsizex do
        for j = 1, gridsizey do
            local x,y = i/gridsizex*WIDTH, j/gridsizey*HEIGHT
            table.insert(rects,{x=x,y=y,w=WIDTH/gridsizex,h=HEIGHT/gridsizey,c=color(img:get(math.floor(x),math.floor(y)))})
        end
    end
    return rects
end

local function doImage()
    img = image(WIDTH,HEIGHT)
    setContext(img)
    font("AppleColorEmoji")
    fill(255)
    fontSize(FontSize)
    text(Emoji,WIDTH/2,HEIGHT/2)
    setContext()
    grid = createRects(40,40)
end

function setup()
    parameter.boolean("ShowOriginal",false)
    parameter.number("FontSize",1,1000,500)
    parameter.text("Emoji","🤑")
    parameter.action("Rebuild big emoji",doImage)
    textAlign(CENTER)
    doImage()
end

local function clamp(x,low,high)
    if x < low then return low end
    if x > high then return high end
    return x
end

function draw()
    background(0)
    if ShowOriginal then
        fill(255)
        sprite(img,WIDTH/2,HEIGHT/2,WIDTH,HEIGHT)
    else
        for k,v in ipairs(grid) do
            fill(v.c)
            fontSize(math.min(v.w,v.h))
            text(Emoji,v.x,v.y)
        end
    end
end