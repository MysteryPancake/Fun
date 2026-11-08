-- Chatizzle, By Velkon.
-- All translations provided by Gizoogle.net
function textizzle(text) -- IF someone wants it
	http.Post("http://www.gizoogle.net/textilizer.php",{translatetext = text,translate = "Tranzizzle Dish Shiznit"},function(body)
			local a = body:match(':250px;"/>.*</textarea>'):gsub(':250px;"/>',""):gsub("</textarea>","")
			return a
	end)
end
hook.Add("OnPlayerChat","Textizzle the chat, dawg",function( player, strText, bTeamOnly, bPlayerIsDead )

	-- Being lazy 101
	print(tobool(GetConVar("Chatizzle_enabled")))
	if not tobool(GetConVar("Chatizzle_enabled"):GetInt()) then return end
 	local tab = {}
	
 	if ( bPlayerIsDead ) then
 	table.insert( tab, Color( 255, 30, 40 ) )
 	table.insert( tab, "*DEAD* " )
 	end
	
 	if ( bTeamOnly ) then
 	table.insert( tab, Color( 30, 160, 40 ) )
 	table.insert( tab, "( TEAM ) " )
 	end
	
 	if ( IsValid( player ) ) then
 	table.insert( tab, player )
 	else
 	table.insert( tab, "Console" )
 	end
	
 	table.insert( tab, Color( 255, 255, 255 ) )

 	if strText:len() > 5 then -- No need
 		http.Post("http://www.gizoogle.net/textilizer.php",{translatetext = strText,translate = "Tranzizzle Dish Shiznit"},function(body)
				local a = body:match(':250px;"/>.*</textarea>'):gsub(':250px;"/>',""):gsub("</textarea>","")
				table.insert( tab, ": "..a )
				chat.AddText( unpack( tab ) )
		end)
 	else
		table.insert( tab, ": "..strText )
		chat.AddText( unpack( tab ) )
 	end
	
 	return true

end)
CreateClientConVar("Chatizzle_enabled","1")
print("Loaded chatizzle\n\t~Translations by gizoogle.net\n\t~Addon by Velkon.\n\t~Probably best on sandbox")