hook.Add( "PlayerSay", "KickCommand", function( ply, text )
	if ply:IsAdmin() and string.sub( string.lower( text ), 1, 5 ) == "!kick" then
		local target
		local args = string.sub( text, 7 )
		for _, v in ipairs( player.GetHumans() ) do
			if v:Nick() == args then
				target = v
			end
		end
		if IsValid( target ) then
			target:Kick()
		end
		return ""
	end
end )
