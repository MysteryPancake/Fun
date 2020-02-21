function setup()
    backingMode(RETAINED)
    displayMode(FULLSCREEN)
end

function draw()
    fill(0,3)
    rect(0,0,WIDTH,HEIGHT)
    fill(255)
    ellipse(math.random(WIDTH),math.random(HEIGHT),math.random(10,30))
end
