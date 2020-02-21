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

function setup()
    displayMode(FULLSCREEN)
    backingMode(RETAINED)
end

function draw()
    rectMode(CORNER)
    fill(0,20)
    rect(0,0,WIDTH,HEIGHT)
    rectMode(CENTER)
    fill(HSVToRGB(Gravity.x*50,1,1))
    rect(WIDTH/2+Gravity.x*WIDTH/2,HEIGHT/2+Gravity.y*HEIGHT/2,math.abs(Gravity.z*WIDTH/2),math.abs(Gravity.z*HEIGHT/2))
end
