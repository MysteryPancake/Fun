hook.Add( "PlayerSay", "Discord", function( ply, text, team )
	http.Post( "https://discordapp.com/api/webhooks/WEBHOOK_ID/WEBHOOK_TOKEN", { content = text, username = ply:Nick() } )
end )
