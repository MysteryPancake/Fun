concommand.Add( "mute_player", function( ply, cmd, args, argStr )
    if ply:IsAdmin() then
        local target
        for _, v in ipairs( player.GetHumans() ) do
            if v:Nick() == argStr then
                target = v
            end
        end
        if IsValid( target ) then
            target.muted = true
            print( "Player muted!" )
        else
            print( "Couldn't find player " .. argStr .. "!" )
        end
    end
end )
