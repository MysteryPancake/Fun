function setup()
    displayMode(FULLSCREEN)
    backingMode(RETAINED)
    stroke(255)
end

function draw()
    strokeWidth(0)
    fill(0,50)
    rect(0,0,WIDTH,HEIGHT)
    strokeWidth(5)
    local prevx
    for i = 1, WIDTH, WIDTH/20 do
        local x = HEIGHT/2 + math.sin(ElapsedTime*3+i/100) * HEIGHT/4
        if prevx then
            line(i,prevx,i,x)
        end
        prevx = x
    end
end