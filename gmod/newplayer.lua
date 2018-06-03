-- lua/autorun/client/cl_init.lua:

net.Receive( "NEW_PLAYER", function()
	local ply = net.ReadEntity()
	chat.AddText( Color( 255, 0, 0 ), ply:Nick() .. " just connected, welcome!" )
end )

-- lua/autorun/server/sv_init.lua:

util.AddNetworkString( "NEW_PLAYER" )

hook.Add( "PlayerInitialSpawn", "NEW_PLAYER", function( ply )
	net.Start( "NEW_PLAYER" )
	net.WriteEntity( ply )
	net.Broadcast()
end )
