local blocked = { [ TEAM_STAFF ] = true, [ TEAM_STAFF2 ] = true, [ TEAM_STAFF3 ] = true }

hook.Add( "AllowPlayerPickup", "NoJobPickup", function( ply )
    return not blocked[ ply:Team() ]
end )
