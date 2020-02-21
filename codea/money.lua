function setup()
    displayMode(FULLSCREEN)
    cash = 0
    w = WIDTH/5
    g = 255
    font("Futura-CondensedMedium")
    textAlign(CENTER)
end

function touched(touch)
    if touch.state == BEGAN then
        sound(SOUND_RANDOM,4)
        cash = cash + math.random(2,5)/100
        w = WIDTH/4
        g = 0
    end
end

function draw()
    background(0,g,0)
    if w > WIDTH/5 then w = w - 5 end
    if g < 255 then g = g + 20 end
    fontSize(w)
    fill(g,255,g)
    text("$"..cash,WIDTH/2,HEIGHT/2)
end