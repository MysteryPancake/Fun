function setup()
    cameraSource(CAMERA_FRONT)
    parameter.number("PlaybackRate",0,1,0.25)
    parameter.number("RecordRate",0.1,2,0.5)
    nextimg = 0
    imgs = {}
    frame = 1
    playing = true
end

function draw()
    background(0)
    if ElapsedTime > nextimg then
        local img = image(CAMERA)
        table.insert(imgs,img)
        nextimg = ElapsedTime + RecordRate
    end
    if #imgs > 0 then
        fill(255)
        sprite(imgs[math.floor(frame)],WIDTH/2,HEIGHT/2,math.min(spriteSize(CAMERA),WIDTH))
        if playing then
            frame = frame + PlaybackRate
            if frame > #imgs then frame = 1 end
        end
    end
end

function touched(touch)
    frame = CurrentTouch.x / WIDTH * #imgs + 1
    playing = touch.state == ENDED
end
