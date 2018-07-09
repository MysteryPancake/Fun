util.AddNetworkString( "mute_message" ) 

local muted = {}

hook.Add( "PlayerSay", "MuteMessage", function( ply )
	if muted[ ply:Nick() ] then
		net.Start( "mute_message" )
		net.Send( ply )
        return ""
    end
end )

hook.Add( "PlayerSay", "ChatCommand", function( ply, text )
	if ply:IsAdmin() and string.sub( string.lower( text ), 1, 5 ) == "!mute" then
		local target = string.sub( text, 7 )
		muted[ target ] = true
		return ""
	end
end )
