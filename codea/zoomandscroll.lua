local function hsvToRgb(h, s, v)
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

  return r * 255, g * 255, b * 255
end
    
function setup()
    displayMode(FULLSCREEN)
    parameter.boolean("UseGravity",false)
    parameter.number("GravityScale",0,100,30)
    parameter.boolean("DrawSize",false)
    parameter.boolean("ColorSize",false)
    parameter.boolean("DrawMaxMin",false)
    font("HelveticaNeue-Bold")
    shapes = {}
    min,max = 10,40
    for i = 1, 40 do
        shapes[i] = {
        x = math.random(WIDTH),
        y = math.random(HEIGHT),
        s = math.random(min,max)
        }
    end
end

function touched(touch)
    if touch.state == MOVING then
        for k,v in ipairs(shapes) do
            v.x = v.x+(v.s/max*touch.deltaX)
            v.y = v.y+(v.s/max*touch.deltaY)
            if v.x+v.s<0 then
                v.x = WIDTH+v.s
                v.y = math.random(HEIGHT)
            elseif v.x-v.s>WIDTH then
                v.x = -v.s
                v.y = math.random(HEIGHT)
            end
            if v.y+v.s<0 then
                v.x = math.random(WIDTH)
                v.y = HEIGHT+v.s
            elseif v.y-v.s>HEIGHT then
                v.x = math.random(WIDTH)
                v.y = -v.s
            end
        end
    end
    if touch.tapCount > 1 then zoom = {x=touch.x,y=touch.y,t=ElapsedTime} end
end

function drawshape(x,y,s)
    if ColorSize then
        local frac = (s-min)/(max-min)
        fill(hsvToRgb(frac,1,1))
    else
        fill(255)
    end
    ellipse(x,y,s)
    if DrawSize then
        fill(ColorSize and 255 or 0)
        fontSize(s/2)
        text(s,x,y)
    end
    if DrawMaxMin then
        fill(255, 0, 0)
        fontSize(s)
        if s == max then
            text("MAX",x,y+s)
        elseif s == min then
            text("MIN",x,y+s)
        end
    end
end

function zoomIn()
    for k,v in ipairs(shapes) do
        v.x = v.x+((v.x-zoom.x)/(max-v.s))*(0.5-(ElapsedTime-zoom.t))
        v.y = v.y+((v.y-zoom.y)/(max-v.s))*(0.5-(ElapsedTime-zoom.t))
    end
    if ElapsedTime-zoom.t > 0.5 then zoom = nil end
end

function draw()
    background(0)
    if zoom then zoomIn() end
    for k,v in ipairs(shapes) do
        if UseGravity then
            drawshape(v.x+Gravity.x*v.s*GravityScale,v.y+Gravity.y*v.s*GravityScale,v.s)
        else
            drawshape(v.x,v.y,v.s)
        end
    end
end
