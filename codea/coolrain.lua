function setup()
    backingMode(RETAINED)
    displayMode(FULLSCREEN)
    min,max = 10,30
    snow = {}
    white = false
    for i = 1, 50 do
        snow[i] = {
        x = math.random(WIDTH),
        y = math.random(HEIGHT),
        s = math.random(min,max)
        }
    end
end

function DrawSnow()
    for k,v in pairs(snow) do
        if white then
            fill(255)
        else
            fill(v.s/max*255,v.s/max*255,Gravity.y*255)
        end
        ellipse(v.x,v.y,v.s)
    end
end

function touched(touch)
    if touch.state == BEGAN then
        white = true
    elseif touch.state == ENDED then
        white = false
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
    if white then
        fill(50,0,Gravity.y*50,20)
    else
        fill(Gravity.y*50,40, 0, 20)
    end
    rect(0,0,WIDTH,HEIGHT)
    DrawSnow()
    UpdateSnow()
end