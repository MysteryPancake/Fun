hook.Add( "PlayerSay", "KickCommand", function( ply, txt )
	if ply:IsAdmin() and string.sub( string.lower( txt ), 1, 5 ) == "!kick" then
		local target
		local args = string.sub( txt, 7 )
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
