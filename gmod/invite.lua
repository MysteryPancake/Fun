hook.Add( "OnPlayerChat", "Discord", function( ply, text )
	if ply == LocalPlayer() and string.lower( text ) == "!discord" then
		gui.OpenURL( "https://discordapp.com/invite/KruZzTv" )
		return true
	end
end )
