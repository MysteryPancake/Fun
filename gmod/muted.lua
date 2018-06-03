-- SERVERSIDE:
util.AddNetworkString( "mute_message" )

hook.Add( "PlayerSay", "MuteMessage", function( ply )
	if ply.muted then
		net.Start( "mute_message" )
		net.Send( ply )
		return ""
	end
end )

-- CLIENTSIDE:
net.Receive( "mute_message", function()
	chat.AddText( Color( 0, 255, 0 ), "YOU ARE MUTED, SHUT UP" )
end )
