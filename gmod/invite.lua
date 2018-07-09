hook.Add( "OnPlayerChat", "Discord", function( ply, txt )
	if ply == LocalPlayer() and string.lower( txt ) == "!discord" then
		gui.OpenURL( "https://discordapp.com/invite/KruZzTv" )
		return true
	end
end )
