function setup()
    blobs = {}
    displayMode(FULLSCREEN)
end

function draw()
    background(0)
    blendMode(ADDITIVE)
    for k, blob in ipairs(blobs) do
        fill(blob.c,blob.c,255,200)
        ellipse(blob.x,blob.y,blob.s)
        blob.c = blob.c-2
        blob.vy = blob.vy - blob.s/100
        blob.x = blob.x + blob.vx
        blob.y = blob.y + blob.vy
        if blob.x < 0 or blob.x > WIDTH or blob.y < 0 then
            table.remove(blobs,k)
        end
    end
end

function touched(touch)
    table.insert(blobs,{
        x = touch.x,
        y = touch.y,
        s = math.random(10,30),
        vx = touch.deltaX/5,
        vy = touch.deltaY/5,
        c = 255
    })
end
