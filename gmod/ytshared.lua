if SERVER then

	util.AddNetworkString( "YoutubeMSG" )

	hook.Add( "PlayerSay", "PlayerSayExample", function( ply, text, team )
		if string.sub( text, 1, 8 ) == "/playnow" then
			local DankMemes = string.sub( text, 10 )
			net.Start( "YoutubeMSG" )
			net.WriteString( DankMemes )
			net.Send( ply )
			return "Now Playing: " .. DankMemes
		end
	end )

else

	net.Receive( "YoutubeMSG", function()

		local frame = vgui.Create( "DFrame" )
		frame:SetTitle( "YouTube" )
		frame:SetSize( ScrW() * 0.75, ScrH() * 0.75 )
		frame:Center()
		frame:MakePopup()

		local html = vgui.Create( "HTML", frame )
		html:Dock( FILL )
		html:OpenURL( net.ReadString() )

	end )

end
