function setup()
    displayMode(FULLSCREEN)
    backingMode(RETAINED)
    blobs = {}
end

function draw()
    fill(0,50)
    rect(0,0,WIDTH,HEIGHT)
    for k, blob in ipairs(blobs) do
        fill(255)
        ellipse(blob.x,blob.y,blob.s)
        blob.vy = blob.vy - blob.s/50
        blob.x = blob.x + blob.vx
        blob.y = blob.y + blob.vy
        local half = blob.s/2
        if blob.y < half then
            blob.y = half
            blob.vy = -blob.vy
        end
        if blob.y > HEIGHT-half then
            blob.y = HEIGHT-half
            blob.vy = -blob.vy
        end
        if blob.x < half then
            blob.x = half
            blob.vx = -blob.vx
        end
        if blob.x > WIDTH-half then
            blob.x = WIDTH-half
            blob.vx = -blob.vx
        end
    end
end

function touched(touch)
    table.insert(blobs,{
    x = touch.x,
    y = touch.y,
    s = math.random(10,30),
    vx = touch.deltaX/5,
    vy = touch.deltaY/5
    })
end
