local function capture()
    local img = image(CAMERA)
    for i = 1, img.width, 10 do
        for j = 1, img.height, 10 do
            table.insert(pixels,{x=i/2,y=j/2,w=5,h=5,c=color(img:get(i,j))})
        end
    end
    captured = true
end

function setup()
    parameter.action("Capture",capture)
    parameter.number("ChromaKey",0,255,0)
    noSmooth()
    captured = false
    pixels = {}
end

function draw()
    background(0)
    if captured then
        for _,v in ipairs(pixels) do
            if v.c.g > ChromaKey then
            fill(v.c)
            rect(v.x,v.y,v.w,v.h)
            end
        end
    else
        fill(255)
        sprite(CAMERA,WIDTH/2,HEIGHT/2,math.min(spriteSize(CAMERA),WIDTH))
    end
end