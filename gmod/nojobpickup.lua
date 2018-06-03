hook.Add( "AllowPlayerPickup", "NoJobPickup", function( ply )
    return ply:Team() ~= TEAM_STAFF
end )
