function setup()
    displayMode(FULLSCREEN)
    textMode(CENTER)
    textAlign(CENTER)
    font("Futura-Medium")
    textWrapWidth(WIDTH)
    tbl = {}
    count = 0
end

function calculate()
    local thing = math.random(0,1)..math.random(0,1)..math.random(0,1)
    if not tbl[thing] then
        tbl[thing] = true
        count = count + 1
    end
end

function draw()
    for i = 1, 5 do calculate() end
    background(0)
    fill(255)
    fontSize(50)
    text("Count: "..count,WIDTH/2,HEIGHT-50)
    local str = ""
    for k,_ in pairs(tbl) do
        str = str..k..""
    end
    fontSize(50-(count/5))
    text(str,WIDTH/2,HEIGHT/2)
end
