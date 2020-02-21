function setup()
    touches = {}
    touchnums = {}
    strokeWidth(20)
    displayMode(FULLSCREEN)
end

function touched(touch)
    if touch.state == ENDED then
        touches[touchnums[touch.id]] = nil
        touchnums[touch.id] = nil
    elseif touch.state == MOVING then
        touches[touchnums[touch.id]] = touch
    elseif touch.state == BEGAN then
        table.insert(touches,touch)
        touchnums[touch.id] = #touches
    end
end

function draw()
    background(0)
    local prev
    for k,v in pairs(touches) do
        if prev then
            math.randomseed(v.id)
            stroke(math.random(255),math.random(255),math.random(255))
            line(prev.x,prev.y,v.x,v.y)
        end
        prev = touches[k]
    end
end