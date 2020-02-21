function setup()
    background(0)
    backingMode(RETAINED)
    middle = vec2(WIDTH/2,HEIGHT/2)
    y = 0
    done = false
end

function DoTrace(pos)
    local dist = pos:dist(middle)
    return color(math.sin(dist)*255,math.cos(dist)*255,math.tan(dist)*255)
end

function draw()
    if not done then
        for x = 0, WIDTH do
            fill(DoTrace(vec2(x,y)))
            rect(x,y,1,1)
        end
        y = y + 1
        if y > HEIGHT then
            done = true
        end
    end
end
