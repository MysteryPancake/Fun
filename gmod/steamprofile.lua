local function OpenSteamProfile( ply, text )

	if ply ~= LocalPlayer() then return end -- OnPlayerChat is called for every single player that chats, so only show the profile if you requested it.

	if string.sub( text, 1, 8 ) == "/profile" then -- If the first 8 characters of what the player said are '/profile'

		local name = string.sub( text, 10 ) -- The name will be anything past 10 characters

		local ply -- This makes a nil variable to be set as whatever player is found below:
		for _, v in ipairs( player.GetHumans() ) do -- For each player in all the players, find the one with the right name
			if v:Nick() == name then ply = v end -- If the name is equal to the player's nickname then set it
		end

		if ply then ply:ShowProfile() end -- If it found a player then show their profile

		return true -- Stops the message from displaying in the chat

	end

end

hook.Add( "OnPlayerChat", "OpenSteamProfile", OpenSteamProfile )
