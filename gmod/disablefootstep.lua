local disabled = { [ "90071996842377216" ] = true, [ "90071996842377218" ] = true }

hook.Add( "PlayerFootstep", "DisableFootstep", function( ply )
	if disabled[ ply:SteamID64() ] then return true end
end )
