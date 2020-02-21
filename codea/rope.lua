function setup()
    displayMode(FULLSCREEN)
    blobs = {}
    for i = 1, 50 do
        blobs[i] = {x=WIDTH/2,y=HEIGHT/2,s=i}
    end
end

function draw()
    background(0)
    stroke(255)
    for k,v in ipairs(blobs) do
        v.x = v.x-(v.x-CurrentTouch.x)/v.s
        v.y = v.y-(v.y-CurrentTouch.y)/v.s
        if prev then
            strokeWidth(v.s)
            line(prev.x,prev.y,v.x,v.y)
        end
        prev = v
    end
    prev = nil
end
