--backingMode(RETAINED) -- uncomment this and remove line 58 for cool effects

function setup()
    sparks = {}
    parameter.integer("Shakiness",0,10,1)
    parameter.number("ColorShakiness",0,500,150)
    parameter.number("SizeDecay",1,5,1.03)
    parameter.number("ColorDecay",0,50,15)
    parameter.number("RemoveSize",1,50,3)
    parameter.boolean("BounceOffEdges",true)
    parameter.integer("MinSize",0,1000,5)
    parameter.integer("MaxSize",0,1000,50)
    parameter.integer("Speed",0,200,1)
    parameter.integer("MinParticles",0,50,2)
    parameter.integer("MaxParticles",1,50,5)
    blendMode(ADDITIVE)
end

local function drawPolygon(x,y,radius,verts,rotation,col)
    local m = mesh()
    local poly = {}
    for i = 1, verts do
        local a = math.rad((i/verts)*-360+rotation)
        table.insert(poly,vec2(x+math.sin(a)*radius,y+math.cos(a)*radius))
    end
    for _,v in pairs(triangulate(poly)) do
        table.insert(m.vertices,v)
    end
    --return poly
    m.vertices = triangulate(poly)
    m:setColors(col)
    m:draw()
end

local function drawSpark(x,y,s,v,r,c)
    local rnd = math.random()*ColorShakiness
    c = color(c.r+rnd,c.g+rnd,c.b+rnd)
    drawPolygon(x,y,s,v,r,c)
end

function touched(touch)
    if touch.state == ENDED then return end
    for i = 1, math.random(MinParticles,MaxParticles) do
        table.insert(sparks,{
        x = touch.x,
        y = touch.y,
        xv = math.random(-Speed,Speed),
        yv = math.random(-Speed,Speed),
        s = math.random(MinSize,MaxSize),
        c = color(255, 255, 0)
        })
    end
end

function draw()
    background(0) -- remove this and uncomment line 3 for cool effects
   -- m = mesh()
    for k,sp in ipairs(sparks) do
        drawSpark(sp.x,sp.y,sp.s,math.random(3,6),math.random(360),sp.c)
        
        sp.x = sp.x + sp.xv
        sp.y = sp.y + sp.yv
        if BounceOffEdges then
            if sp.x <= 0 or sp.x >= WIDTH then sp.xv = -sp.xv end
            if sp.y <= 0 or sp.y >= HEIGHT then sp.yv = -sp.yv end
        end
        sp.xv = sp.xv + math.random(-Shakiness,Shakiness)
        sp.yv = sp.yv + math.random(-Shakiness,Shakiness)
        sp.c.g = sp.c.g - math.random()*ColorDecay
        sp.s = sp.s/SizeDecay
        if sp.s < RemoveSize then
            table.remove(sparks,k)
        end
    end
    -- poly.vertices = triangulate(poly.vertices)
    --m:setColors(255,255,255,255)
   -- m:draw()
   -- m = nil
end