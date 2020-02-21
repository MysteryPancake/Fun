function setup()
    parameter.number("dots",1,500,10)
    parameter.number("size",1,50,3)
end

function draw()
    background(0)
    sprite(CAMERA,WIDTH/2,HEIGHT/2,math.min(spriteSize(CAMERA),WIDTH))
    fill(0)
    for i = 1, dots do
        ellipse(math.random(WIDTH),math.random(HEIGHT),size)
    end
end