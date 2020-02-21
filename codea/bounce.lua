function setup()
    backingMode(RETAINED)
    background(0)
    x = WIDTH/2
    y = HEIGHT/2
    velx = 0
    vely = 0
    moving = true
    parameter.number("ClearAmount",0,255,60)
    parameter.number("GravityMultiplier",0,2,1)
    parameter.number("Size",2,400,50)
end

function touched(touch)
    moving = touch.state == ENDED
    x = touch.x
    y = touch.y
    velx = 0
    vely = 0
end

function draw()
    if moving then
        local half = Size/2
        velx = velx + (Gravity.x*GravityMultiplier)
        vely = vely + (Gravity.y*GravityMultiplier)
        x = x + velx
        y = y + vely
        if y < half then
            y = half
            vely = -vely
        end
        if y > HEIGHT-half then
            y = HEIGHT-half
            vely = -vely
        end
        if x < half then
            x = half
            velx = -velx
        end
        if x > WIDTH-half then
            x = WIDTH-half
            velx = -velx
        end
    end
    fill(0,ClearAmount)
    rect(0,0,WIDTH,HEIGHT)
    fill(255)
    ellipse(x,y,Size)
end
