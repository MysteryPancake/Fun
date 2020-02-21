function setup()
    textMode(CENTER)
    textAlign(CENTER)
    speech.volume = 10
    textWrapWidth(WIDTH)
    parameter.text("Text","Ah, sama lamaa duma lamaa you assuming I'm a human, what I gotta do to get it through to you I'm superhuman, innovative and I'm made of rubber so that anything you saying ricocheting off of me and it'll glue to you.")
    parameter.action("Speak",function()
        speech.stop(true)
        speech.say(Text)
    end)
    parameter.integer("Voice",1,#speech.voices,1,function(n)
        speech.voice = speech.voices[n]
    end)
    parameter.number("Pitch",0.5,2,0.5,function(n)
        speech.pitch = n
    end)
    parameter.number("Rate",0,1,0,function(n)
        speech.rate = n
    end)
end

function draw()
    background(0)
    fill(150)
    font("AmericanTypewriter")
    fontSize(25)
    text(Text,WIDTH/2,HEIGHT/2)
    fill(255)
    font("HelveticaNeue-Light")
    fontSize(80)
    text(Voice.."/"..#speech.voices,WIDTH/2,HEIGHT/3*2)
    fontSize(30)
    text(tostring(speech.voice),WIDTH/2,HEIGHT/3)
end