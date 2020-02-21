function setup()
    backingMode(RETAINED)
    displayMode(FULLSCREEN)
    textAlign(CENTER)
    
    --using = UserAcceleration
    --using = RotationRate
    using = Gravity
    initial = 0
    bg = 40
    done = 0
    xmax,xmin,ymax,ymin,zmax,zmin = 0,0,0,0,0,0
    bgdrawn = false
    m = mesh()
    m.colors = {
    color(0, 50, 0),color(0,255,0),color(0, 50, 0),color(0, 255, 0),color(0, 50, 0),color(0, 255, 0)
    }
end

function HSVToRGB(h, s, v, a)
    local r, g, b
    local i = math.floor(h * 6);
    local f = h * 6 - i;
    local p = v * (1 - s);
    local q = v * (1 - f * s);
    local t = v * (1 - (1 - f) * s);
    i = i % 6
    if i == 0 then r, g, b = v, t, p
    elseif i == 1 then r, g, b = q, v, p
    elseif i == 2 then r, g, b = p, v, t
    elseif i == 3 then r, g, b = p, q, v
    elseif i == 4 then r, g, b = t, p, v
    elseif i == 5 then r, g, b = v, p, q
    end
    return r * 255, g * 255, b * 255, a or 255
end

function AccelChange(acc)
    if acc.x < xmin or acc.x > xmax then return true end
    if acc.y < ymin or acc.y > ymax then return true end
    if acc.z < zmin or acc.z > zmax then return true end
    return false
end

function CheckMovement()
    if AccelChange(using) then
        stroke(255,255,0)
        strokeWidth(10)
        line(math.random(WIDTH),math.random(HEIGHT),math.random(WIDTH),math.random(HEIGHT))
    end
end

function UpdateAcceleration(acc)
    xmax = math.max(xmax,acc.x)
    xmin = math.min(xmin,acc.x)
    ymax = math.max(ymax,acc.y)
    ymin = math.min(ymin,acc.y)
    zmax = math.max(zmax,acc.z)
    zmin = math.min(zmin,acc.z)
end

function draw()
    if initial < HEIGHT then
        if not bgdrawn then
            background(bg)
            bgdrawn = true
            bg = 255
        end
        
        fill(HSVToRGB(initial/HEIGHT,1,1))
        local formula = math.rad(initial/HEIGHT*-360)
        
        local test1 = math.sin(formula)
        local test2 = math.cos(formula)+math.sin(formula)
        
        ellipse(WIDTH/2+(test1*(HEIGHT/4)),HEIGHT/2+(test2*(HEIGHT/4)),50)
        
        local test1 = math.sin(formula)
        local test2 = math.cos(formula)-math.sin(formula)
        
        ellipse(WIDTH/2+(test1*(HEIGHT/4)),HEIGHT/2+(test2*(HEIGHT/4)),50)
        
        local test1 = math.sin(formula)*2
        local test2 = math.cos(formula)/2
        
        ellipse(WIDTH/2+(test1*(HEIGHT/4)),HEIGHT/2+(test2*(HEIGHT/4)),50)
        
        initial = initial+3
        
    elseif done < WIDTH then
        background(bg)
        if bg > 40 then
            bg = bg - 5
            if bg < 40 then bg = 40 end
        end
        UpdateAcceleration(using)
        done = done + 1
        m.vertices = {vec2(0,0),vec2(done,0),vec2(0,HEIGHT),vec2(done,0),vec2(0,HEIGHT),vec2(done,HEIGHT)}
        m:draw()
        fill(255)
        font("HelveticaNeue-Light")
        fontSize(WIDTH/20)
        text("Recording Current Movement",WIDTH/2,HEIGHT/2)
        fill(bg)
        font("HelveticaNeue")
        fontSize(WIDTH/60)
        local coolpos = (done/WIDTH)*4
        text(xmin,WIDTH/4,HEIGHT/coolpos)
        text(xmax,WIDTH/4,HEIGHT-HEIGHT/coolpos)
        text(ymin,WIDTH/2,HEIGHT/coolpos)
        text(ymax,WIDTH/2,HEIGHT-HEIGHT/coolpos)
        text(zmin,WIDTH-WIDTH/4,HEIGHT/coolpos)
        text(zmax,WIDTH-WIDTH/4,HEIGHT-HEIGHT/coolpos)
    else
        fill(bg,30)
        rect(0,0,WIDTH,HEIGHT)
        CheckMovement()
    end
    
end