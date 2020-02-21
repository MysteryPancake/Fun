function setup()
    displayMode(FULLSCREEN)
    backingMode(RETAINED)
    blobs = {}
    touches = {}
    for i = 10, 30 do
        table.insert(blobs,{x=math.random(WIDTH),y=math.random(HEIGHT),s=i})
    end
end

function touched(touch)
    if touch.state == ENDED then
        touches[touch.id] = nil
    else
        touches[touch.id] = touch
        if touch.state == BEGAN then
            for i = 1, 20 do
                blobs[i].t = nil
            end
        end
    end
end

function draw()
    fill(0,10)
    rect(0,0,WIDTH,HEIGHT)
    fill(255)
    local meme = {}
    for k,v in pairs(touches) do
        table.insert(meme,v)
    end
    for k,v in ipairs(blobs) do
        ellipse(v.x,v.y,v.s)
        if #meme > 0 then
            if not meme[v.t] then v.t = math.random(#meme) end
            local t = meme[v.t]
            v.x = v.x-((v.x-t.x)*v.s/500)
            v.y = v.y-((v.y-t.y)*v.s/500)
        end
    end
end
