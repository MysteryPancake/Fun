function setup()
    displayMode(FULLSCREEN)
end

function draw()
    background(0)
    stroke(255)
    strokeWidth(20)
    line(CurrentTouch.prevX,CurrentTouch.prevY,CurrentTouch.x,CurrentTouch.y)
end
