util.AddNetworkString( "mute_message" ) 

local muted = {}

hook.Add( "PlayerSay", "MuteMessage", function( ply )
	if muted[ ply:Nick() ] then
		net.Start( "mute_message" )
		net.Send( ply )
        return ""
    end
end )

hook.Add( "PlayerSay", "ChatCommand", function( ply, txt )
	if ply:IsAdmin() and string.sub( string.lower( txt ), 1, 5 ) == "!mute" then
		local args = string.Split( string.sub( txt, 7 ), " " )
		muted[ args[ 1 ] ] = true
		timer.Simple( tonumber( args[ 2 ] or 0 ), function()
			muted[ args[ 1 ] ] = false
		end )
		return ""
	end
end )
