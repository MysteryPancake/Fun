-- THIS FILE IS INCREDIBLY BROKEN AND HAS MANY PROBLEMS
-- Now known as Waveform

supportedOrientations( ANY )

function setup()
    
    displayMode( FULLSCREEN )
    
    physics.gravity( 0, -2000 )
    
    --sound("Project:C", 1, 1, 0, true) -- change this
    
    m = mesh()
    
    water = {}
    touches = {}
    waterblobs = {}
    
    baseheight=HEIGHT*2/3
    numsprings=30
    total = WIDTH/numsprings
    
    for i=1, WIDTH+total, total do
        table.insert(water,{x=i,y=baseheight,vel=0})
    end
    
    springconstant = 0.02
    damping = 0.02
    spread = 0.03
    neighbours = 9
    
    lightcol = color(135, 80, 40)
    darkcol = color(53, 46, 34)
    glowcol = color(219, 223, 165)
    
    leftDeltas={}
    rightDeltas={}
    bottom=0
    
end

function orientationChanged(new)
    baseheight=(HEIGHT/3)*2
    numsprings=30
    total = WIDTH/numsprings
    if water then
        local n = 1
        for i=1, WIDTH+total, total do
            if water[n] then water[n].x=i end
            n = n+1
        end
    end
end

function touched(touch)
    if touch.state == ENDED then
        touches[touch.id] = nil
    else
        touches[touch.id] = touches[touch.id] or {}
        touches[touch.id].t=touch
        if touch.state == BEGAN then
            touches[touch.id].prev = touch.y
        end
    end
end

local function nearishbreak(x,y,dist,full)
    if y > x then return (math.max(0,dist-(y-x))/dist)*full end
    return false
end

local function nearish(x,y,dist,full)
    if y > x then return (math.max(0,dist-(y-x))/dist)*full end
    if x > y then return (math.max(0,dist-(x-y))/dist)*full end
    return full
end

local function GetNearSpring(x)
    return math.ceil((numsprings)*x/WIDTH)
end

local function CurveWater(spring,near)
    if not water[spring] then return end
    water[spring].y=baseheight+near
    water[spring].vel=0
    if not water[spring-1] then return end
    water[spring-1].y= baseheight+(near/1.1)
    water[spring-1].vel = 0
    if not water[spring+1] then return end
    water[spring+1].y= baseheight+(near/1.1)
    water[spring+1].vel = 0
end

local function CurveWater2(t,spring)
    if not water[spring] then return end
    water[spring].y=baseheight+((t.t.y-t.prev)/2)
    water[spring].vel=0
end

local function DrawTouch(touch)
    local diff = math.abs(touch.t.deltaX)+math.abs(touch.t.deltaY)
    --touch.op = (touch.op and touch.op + diff) or 0
    local glow = glowcol
    glow.alpha = diff*10
    tint(glow)
    --[[for i = -1,1 do
    sprite("Project:glow",touch.t.x+(i*200),touch.t.y,500)
end]]
end

local function AddBlob(touch,spring)
    
    local blobsize = (touch.t.y-touch.prev)/2
    
    if blobsize < 50 then touch.badblob = true return end
    
    local blob = physics.body(CIRCLE,blobsize/2)
    blob.x = touch.t.x
    blob.y = touch.t.y+(blobsize/2)
    blob.density = 1
    blob.restitution = 0.1
    blob.interpolate = true
    table.insert(waterblobs,blob)
    touch.holdingblob = true
    touch.blob = blob
    
    water[spring].y = touch.t.y
    baseheight = baseheight - (blobsize/2)
    
    if baseheight < 100 then baseheight = (HEIGHT/3)*2 end
    
end

function draw()
    
    background(29, 32, 45, 255)
    
    for k,v in pairs(touches) do
        if v.holdingblob then
            
            local worldAnchor = vec2(v.blob.x,v.blob.y)
            local touchPoint = vec2(v.t.x,v.t.y)
            local diff = touchPoint - worldAnchor
            local vel = v.blob:getLinearVelocityFromWorldPoint(worldAnchor)
            if vel then
                v.blob:applyForce(diff*50-vel*5)
            end
            
        elseif not v.badblob then
            
            local nearestspring=GetNearSpring(v.t.x)
            
            if water[nearestspring] and (v.prev<baseheight) then
                local near = nearishbreak(v.t.y,baseheight,HEIGHT/5,100)
                if not near then
                    AddBlob(v,nearestspring)
                else
                    --CurveWater(nearestspring,near)
                    CurveWater2(v,nearestspring)
                end
            end
        end
    end
    
    for u,w in ipairs(water) do
        local force = springconstant * (w.y - baseheight) + (w.vel*damping)
        w.y = w.y + w.vel
        w.vel = w.vel - force
    end

    for j=1,neighbours do
        for i=1,numsprings+1 do
            if (i > 1) then
                leftDeltas[i] = spread * (water[i].y - water[i-1].y);
                water[i-1].vel = water[i-1].vel + leftDeltas[i];
            end
            if (i < numsprings+1) then
                rightDeltas[i] = spread * (water[i].y - water[i+1].y);
                water[i+1].vel=water[i+1].vel + rightDeltas[i];
            end
        end
    end
    for i=1,numsprings+1 do
            if (i > 1) then
                water[i-1].y =water[i-1].y+ leftDeltas[i];
            end
            if (i < numsprings+1) then
                water[i+1].y=water[i+1].y + rightDeltas[i];
            end
        end
    
    for k,v in ipairs(waterblobs) do
        if (v.x+v.radius < 0) or (v.x-v.radius > WIDTH) or (v.y+v.radius<0) then
            v:destroy()
            table.remove(waterblobs,k)
        else
            local near = GetNearSpring(v.x)
            if water[near] and (water[near].y > v.y+v.radius) then
                --local ish = nearish(v.y,water[near].y,v.radius*2,v.radius)
                --CurveWater(near,ish) -- uncomment to make water curve toward blobs
                water[near].y = v.y-(v.linearVelocity.y/5) -- bump the water
                baseheight = math.min(baseheight+v.radius,(HEIGHT/3)*2) -- add the blob back on
                v:destroy()
                table.remove(waterblobs,k)
            end
        end
    end
    
    fill(lightcol)
    stroke(178, 98, 21, 255)
    strokeWidth(10)
    for k,v in ipairs(waterblobs) do
        ellipse(v.x,v.y,v.radius*2)
    end
    
    local verts = {}
    local colors = {}
    local lines = {}
    for i = 1, numsprings do
        table.insert(verts,vec2(water[i].x,water[i].y))
        table.insert(verts,vec2(water[i+1].x,water[i+1].y))
        table.insert(verts,vec2(water[i+1].x,bottom))
        table.insert(verts,vec2(water[i+1].x,bottom))
        table.insert(verts,vec2(water[i].x,bottom))
        table.insert(verts,vec2(water[i].x,water[i].y))
        table.insert(colors,lightcol)
        table.insert(colors,lightcol)
        table.insert(colors,darkcol)
        table.insert(colors,darkcol)
        table.insert(colors,darkcol)
        table.insert(colors,lightcol)
        table.insert(lines,{x=water[i].x,y=water[i].y,x2=water[i+1].x,y2=water[i+1].y})
    end
    m.vertices = verts
    m.colors = colors
    m:draw()
    
    for k,v in ipairs(lines) do
        line(v.x,v.y,v.x2,v.y2)
    end
    
    noStroke()
    for k,v in pairs(touches) do
        DrawTouch(v)
    end
end
