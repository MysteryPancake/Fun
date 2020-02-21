function GetColor()
    local colors = {color(255,0,0),color(255,255,0),color(0,0,255),color(255),color(0)}
    return colors[math.random(#colors)]
end

function MakeTable()
    local tab = {}
    local totl = 0
    for i = 1,math.random(HorizontalMin,HorizontalMax) do
        if WIDTH-totl > 0 then
            local wd = math.random(WIDTH-totl)
            tab[i] = {
            x = i==1 and 0 or totl,
            w = wd,
            c = GetColor()
            }
            totl = totl+wd
        end
    end
    table.insert(tab,{
    x = totl,
    w = WIDTH-totl,
    c = GetColor()
    })
    return tab
end

function MakeArt()
    math.randomseed(os.time())
    t = {}
    local total = 0
    for i = 1,math.random(VerticalMin,VerticalMax) do
        if HEIGHT-total > 0 then
            local ht = math.random(HEIGHT-total)
            t[i] = {
            y = i==1 and 0 or total,
            h = ht,
            t = MakeTable()
            }
            total = total+ht
        end
    end
    table.insert(t,{
    y = total,
    h = HEIGHT-total,
    t = MakeTable()
    })
end

function touched(touch)
    if touch.state == BEGAN then
        MakeArt()
    end
end

function setup()
    parameter.integer("VerticalMin",1,15,3)
    parameter.integer("VerticalMax",1,15,5)
    parameter.integer("HorizontalMin",1,15,1)
    parameter.integer("HorizontalMax",1,15,3)
    MakeArt()
end

function draw()
    background(0)
    for _,v in ipairs(t) do
        for _,tbl in ipairs(v.t) do
            fill(tbl.c)
            rect(tbl.x,v.y,tbl.w,v.h)
        end
    end
end