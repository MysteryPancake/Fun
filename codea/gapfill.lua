function setup()
    displayMode(FULLSCREEN)
    x1 = 100
    y1 = 100
    x2 = WIDTH - 100
    y2 = HEIGHT - 100
    seg = 5
    stroke(50)
    lineCapMode(SQUARE)
end

function draw()
    background(0)
    strokeWidth(50)
    line(x1,y1,x2,y2)
    local xdiff = x2-x1
    local ydiff = y2-y1
    strokeWidth(0)
    for i = 0, seg do
        fill(255)
        ellipse(x1+(xdiff/seg)*i,y1+(ydiff/seg)*i,50)
        fill(0)
        ellipse(x1+(xdiff/seg)*i,y1+(ydiff/seg)*i,25)
    end
end

function touched(touch)
    if touch.state ~= ENDED then
        if not t then t = touch.id end
        if t == touch.id then
            x1 = touch.x
            y1 = touch.y
        else
            x2 = touch.x
            y2 = touch.y
        end
    else
        t = nil
    end
end
