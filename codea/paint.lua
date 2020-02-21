function setup()
    backingMode(RETAINED)
    parameter.color("Color",255)
    parameter.number("Size",1,100,20)
    parameter.boolean("Text",false)
    parameter.text("String","👌🏻")
    touches = {}
    prevTouches = {}
end

function touched(touch)
    if touch.state == ENDED then
        touches[touch.id] = nil
        prevTouches[touch.id] = nil
    else
        touches[touch.id] = touch
    end
end

function draw()
    fill(Color)
    stroke(Color)
    for k, touch in pairs(touches) do
        if Text then
            fontSize(Size)
            text(String,touch.x,touch.y)
        else
            if prevTouches[k] then
                strokeWidth(Size)
                line(prevTouches[k].x, prevTouches[k].y, touch.x, touch.y)
            else
                strokeWidth(0)
                ellipse(touch.x,touch.y,Size)
            end
            prevTouches[k] = { x = touch.x, y = touch.y }
        end
    end
end