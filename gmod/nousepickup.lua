hook.Add( "AllowPlayerPickup", "NoJobPickup", function( ply )
    local blocked = { [ TEAM_FLITWICK ] = true, [ TEAM_LUPIN ] = true, [ TEAM_SNAPE ] = true, [ TEAM_SUBSTITUTE ] = true }
    return not blocked[ ply:Team() ]
end )
