function HSVToRGB(h, s, v)
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
    i = 1
end

function draw()
    local n = (i/360)*10
    local equation = math.rad(i)
    fill(HSVToRGB(i/360,1,1))
    ellipse(WIDTH/2+math.sin(equation)*n,HEIGHT/2+math.cos(equation)*n,10)
    i = i+10-math.tan(i)
end
