function setup()
    displayMode(FULLSCREEN)
    min,max = 10,30
    snow = {}
    for i = 1, 100 do
        snow[i] = {
        x = math.random(WIDTH),
        y = math.random(HEIGHT),
        s = math.random(min,max)
        }
    end
end

function DrawSnow()
    for k,v in pairs(snow) do
        fill(255)
        ellipse(v.x,v.y,v.s)
    end
end

function touched(touch)
    if touch.state == BEGAN then
        table.insert(snow,{
        x = touch.x,
        y = touch.y,
        s = math.random(min,max)
        })
    end
end

function UpdateSnow()
    for k,v in pairs(snow) do
        v.x = v.x + Gravity.x*v.s/2
        v.y = v.y + Gravity.y*v.s/2
        if v.y+v.s < 0 then
            v.x = math.random(WIDTH)
            v.y = HEIGHT+v.s
        elseif v.y-v.s > HEIGHT then
            v.x = math.random(WIDTH)
            v.y = -v.s
        end
        if v.x-v.s > WIDTH then
            v.x = -v.s
            v.y = math.random(HEIGHT)
        elseif v.x+v.s < 0 then
            v.x = WIDTH+v.s
            v.y = math.random(HEIGHT)
        end
    end
end

function draw()
    background(0)
    sprite(CAMERA,WIDTH/2,HEIGHT/2,math.min(spriteSize(CAMERA),WIDTH))
    DrawSnow()
    UpdateSnow()
end