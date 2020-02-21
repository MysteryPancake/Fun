-- Real train scroller: 96 x 16 px

local function createRects(w,h)
    local rects = {}
    local xw, yh = w/10, h/10
    for i = 1, xw-1 do
        for j = 1, yh-1 do
            local x,y = i/xw*w,j/yh*h
            table.insert(rects,{x=x,y=y,w=w/xw,h=h/yh,c=color(img:get(math.floor(x),math.floor(y))):blend(color(75,60,35))})
        end
    end
    return rects
end

local function drawText()
    fill(255,130,0)
    text(Text,0,0)
end

function createImage()
    local tw,th = textSize(Text)
    img = image(tw+20,th)
    setContext(img)
    drawText()
    setContext()
    grid = createRects(tw+20,th)
end

function setup()
    parameter.boolean("ShowOriginal",false)
    parameter.text("Text","Sample Text",createImage)
    ellipseMode(CORNER)
    textMode(CORNER)
    font("HelveticaNeue-Bold")
    textWrapWidth(WIDTH)
    fontSize(120)
    createImage()
end

function draw()
    background(40,30,25)
    local _,th = textSize(Text)
    local lazy = HEIGHT-th
    translate(0,lazy)
    if ShowOriginal then
        drawText()
    else
        for k,v in ipairs(grid) do
            fill(v.c)
            ellipse(v.x,v.y,v.w,v.h)
        end
    end
    translate(0,-lazy)
end