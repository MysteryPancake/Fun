function setup()
    displayMode(FULLSCREEN)
    backingMode(RETAINED)
    blobs = {}
end

function touched(touch)
    t = touch
    table.insert(blobs,{x=math.random(WIDTH),y=math.random(HEIGHT),s=math.random(10,20),c=math.random(255)})
    if #blobs > 80 then table.remove(blobs,1) end
end

function draw()
    fill(0,20)
    rect(0,0,WIDTH,HEIGHT)
    for k,v in ipairs(blobs) do
        fill(255,v.c,0)
        ellipse(v.x,v.y,v.s)
        if t then
            v.x = v.x-((v.x-t.x)*v.s/500)
            v.y = v.y-((v.y-t.y)*v.s/500)
        end
    end
end
