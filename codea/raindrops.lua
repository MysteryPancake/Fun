function setup()
    displayMode(FULLSCREEN)
    raindrops = {}
    for i = 1, 40 do
        raindrops[i] = {
        x = math.random(WIDTH),
        y = math.random(HEIGHT),
        s = math.random(15,30)
        }
    end
end

function DrawRaindrops()
    for k,v in pairs(raindrops) do
        fill(255, 255, 255, 50)
        ellipse(v.x,v.y,v.s)
    end
end

function UpdateRaindrops()
    for k,v in pairs(raindrops) do
        if math.random(20) == 1 or v.again then
            v.x = v.x + Gravity.x*20
            v.y = v.y + Gravity.y*20
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
            if math.random() > 0.5 then
                v.again = true
            else
                v.again = false
            end
        end
    end
end

function draw()
    background(0)
    sprite(CAMERA,WIDTH/2,HEIGHT/2,math.min(spriteSize(CAMERA),WIDTH))
    DrawRaindrops()
    UpdateRaindrops()
end