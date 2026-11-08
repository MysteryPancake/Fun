concommand.Add("derma_fun", function()
	local ColorButton = vgui.Create( "DColorButton" )
		ColorButton:Dock(FILL)
		ColorButton:SetText( "" )
		ColorButton:SetCursor( "blank" )
		ColorButton:MakePopup()
	ColorButton.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color(math.random(0,255), math.random(0,255), math.random(0,255), 255))
	end
	ColorButton.DoClick = function()
		ColorButton:Remove()
	end
end )