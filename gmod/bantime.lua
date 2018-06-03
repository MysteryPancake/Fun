local banned = {}

hook.Add( "CheckPassword", "CheckBanned", function( id )
	if banned[ id ] then
		return false, "#GameUI_ServerRejectBanned"
	end
end )

hook.Add( "PlayerSay", "BanCommand", function( ply, txt )
	if ply:IsAdmin() and string.sub( string.lower( txt ), 1, 4 ) == "!ban" then
		local target
		local args = string.Split( string.sub( txt, 6 ), " " )
		for _, v in ipairs( player.GetHumans() ) do
			if v:Nick() == args[ 1 ] then
				target = v
			end
		end
		if IsValid( target ) then
			banned[ target:SteamID64() ] = true
			timer.Simple( tonumber( args[ 2 ] or 0 ), function()
				banned[ target:SteamID64() ] = false
			end )
			target:Kick()
		end
		return ""
	end
end )
