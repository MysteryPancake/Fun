hook.Add( "PlayerSay", "Discord", function( ply, text )
	http.Post( "https://discordapp.com/api/webhooks/WEBHOOK_ID_HERE/WEBHOOK_TOKEN_HERE", { content = text, username = ply:Nick() } )
end )
