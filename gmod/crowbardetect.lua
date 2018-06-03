hook.Add( "EntityEmitSound", "blah", function( data )
    if data.OriginalSoundName == "Weapon_Crowbar.Single" then
        print( "Crowbar!" )
    end
end )
