function setup()
    backingMode(RETAINED)
    displayMode(FULLSCREEN)
    prevTouches = {}
    touches = {}
    origins = {}
end

function touched(touch)
    if touch.state == ENDED then
        origins[touch.id] = nil
        touches[touch.id] = nil
        prevTouches[touch.id] = nil
    else
        if touch.state == BEGAN then
            origins[touch.id] = { x = touch.x, y = touch.y }
        end
        touches[touch.id] = touch
    end
end

function draw()
    fill(255)
    stroke(255)
    for k, touch in pairs(touches) do
        local origin = origins[touch.id]
        if origin then
            local normX, normY = origin.x-touch.x, origin.y-touch.y
            if prevTouches[k] then
                strokeWidth(20)
                local prevNormX, prevNormY = origin.x-prevTouches[k].x, origin.y-prevTouches[k].y
                line(origin.x-prevNormX,origin.y-prevNormY,origin.x-normX,origin.y-normY)
                line(origin.x+prevNormX,origin.y+prevNormY,origin.x+normX,origin.y+normY)
                line(origin.x+prevNormY,origin.y-prevNormX,origin.x+normY,origin.y-normX)
                line(origin.x-prevNormY,origin.y+prevNormX,origin.x-normY,origin.y+normX)
            else
                strokeWidth(0)
                ellipse(origin.x+normX,origin.y+normY,20)
                ellipse(origin.x-normX,origin.y-normY,20)
                ellipse(origin.x+normY,origin.y-normX,20)
                ellipse(origin.x-normY,origin.y+normX,20)
            end
            prevTouches[k] = { x = touch.x, y = touch.y }
        end
    end
end