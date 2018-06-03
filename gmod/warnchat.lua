hook.Add( "PlayerSay", "WarnCommand", function( ply, txt )
	if ply:IsAdmin() and string.sub( string.lower( txt ), 1, 5 ) == "!warn" then
		local target
		local args = string.sub( txt, 7 )
		for _, v in ipairs( player.GetHumans() ) do
			if v:Nick() == args then
				target = v
			end
		end
		if IsValid( target ) then
			target.warnings = target.warnings and target.warnings + 1 or 1
			if target.warnings >= 3 then
				target:Kick()
			end
		end
		return ""
	end
end )
