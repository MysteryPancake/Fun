function setup()
    backingMode(RETAINED)
    displayMode(FULLSCREEN)
    balls = {}
    for i = 1, math.random(20,200) do
        table.insert(balls,{
            x=math.random(WIDTH),
            y=math.random(HEIGHT),
            xv=math.random(-10,10),
            yv=math.random(-10,10),
            s=math.random(20,40),
        })
    end
end

function draw()
    fill(0,50)
    rect(0,0,WIDTH,HEIGHT)
    for k,v in ipairs(balls) do
        math.randomseed(k)
        fill(math.random(255),math.random(255),math.random(255))
        ellipse(v.x,v.y,v.s)
        v.x=v.x+v.xv
        if v.x-v.s<0 or v.x+v.s>WIDTH then
            v.xv = -v.xv
        end
        v.y=v.y+v.yv
        if v.y-v.s<0 or v.y+v.s>HEIGHT then
            v.yv = -v.yv
        end
    end
end
