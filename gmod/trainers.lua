hook.Add( "OnPlayerChat", "blah", function( ply, text )
	if ply == LocalPlayer() and text == "!rt" then
		local trainers = {}
		for _, v in ipairs( player.GetHumans() ) do
			if string.sub( v:Nick(), 1, 2 ) == "TR" then
				table.insert( trainers, v )
			end
		end
		chat.AddText( trainers[ math.random( #trainers ) ]:Nick() )
		return true
	end
end )
