function setup()
    touches = {}
    displayMode(FULLSCREEN)
end

function touched(touch)
    if touch.state == ENDED then
        touches[touch.id] = nil
    else
        touches[touch.id] = touch
    end
end

function draw()
    background(0, 0, 0, 255)
    
    for k,touch in pairs(touches) do
        sprite("Project:glow",touch.x,touch.y,400)
        for k,touch2 in pairs(touches) do
            if touch2.id ~= touch.id then
            stroke(255)
            strokeWidth(5)
            line(touch.x,touch.y,touch2.x,touch2.y)
            end
        end
    end
end