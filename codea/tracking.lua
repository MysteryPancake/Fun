function setup()
    displayMode(FULLSCREEN)
    parameter.number("xMultiplier",0,30,15)
    parameter.number("yMultiplier",0,30,15)
    x = WIDTH/2
    y = HEIGHT/2
end

function touched(touch)
    x = touch.x
    y = touch.y
end

function draw()
    background(0)
    sprite(CAMERA,WIDTH/2,HEIGHT/2,math.min(spriteSize(CAMERA),WIDTH))
    sprite("Cargo Bot:Star Filled",x,y,95,92)
    x = x+RotationRate.y*xMultiplier
    y = y-RotationRate.x*yMultiplier
end