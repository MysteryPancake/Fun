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
    rectMode(CENTER)
end

function draw()
    background(255, 0, 0)
    for i = WIDTH,1,-25 do
        local x,y = WIDTH/2+(Gravity.x*i/2),HEIGHT/2+(Gravity.y*i/2)
        fill(hsvToRgb(i/WIDTH,1,1))
        rect(x,y,i,i)
    end
end
