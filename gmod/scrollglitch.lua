concommand.Add( "ScrollTest", function()

	local base = vgui.Create( "DFrame" )
	base:SetSize( 200, 200 )
	base:Center()
	base:MakePopup()
	
	local scroll = vgui.Create( "DScrollPanel", base )
	scroll:Dock( FILL )
	
	local tbl = {}
	
	for i = 1, 3 do
		tbl[ #tbl + 1 ] = vgui.Create( "DPanel", scroll )
		tbl[ #tbl ]:Dock( TOP )
		tbl[ #tbl ]:SetSize( 0, 70 )
	end
	
	timer.Simple( 1, function()
		for k, v in ipairs( tbl ) do
			v:Remove()
			tbl[ k ] = nil
		end
	end )
	
	timer.Simple( 2, function()
		scroll:InvalidateLayout() -- Doesn't work
	end )

end )
