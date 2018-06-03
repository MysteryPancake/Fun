hook.Add( "EntityEmitSound", "blah", function( data )
    if data.Entity:GetClass() == "ambient_generic" and data.SoundName == "sound/rain.mp3" then
        print( "IT'S RAINING!" )
    end
end )
