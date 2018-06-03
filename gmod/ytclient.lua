hook.Add( "OnPlayerChat", "YouTubeMSG", function( ply, text, team, dead )

	if ply ~= LocalPlayer() then return end

	if string.sub( text, 1, 8 ) == "/playnow" then
		
		local frame = vgui.Create( "DFrame" )
		frame:SetTitle( "YouTube" )
		frame:SetSize( ScrW() * 0.75, ScrH() * 0.75 )
		frame:Center()
		frame:MakePopup()

		local html = vgui.Create( "HTML", frame )
		html:Dock( FILL )
		html:OpenURL( string.sub( text, 10 ) )

		return true

	end

end )
