local old = 0
hook.Add( "TTTBeginRound", "blah", function()
	local count = player.GetCount()
	if count > 6 then
		local new = math.random( count )
		while new == old do
			new = math.random( count )
		end
		RunConsoleCommand( "ulx setmodel", player.GetAll()[ new ]:Nick() .. " models/tsbb/animals/african_penguin.mdl" )
		old = new
	end
end )
