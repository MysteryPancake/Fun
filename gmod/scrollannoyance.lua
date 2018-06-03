concommand.Add( "ShowAnnoyance", function()

	local base = vgui.Create( "DFrame" )
	base:SetSize( 200, 200 )
	base:SetTitle( "DSCROLLPANEL IS BEING A PAIN" )
	base:Center()
	base:MakePopup()
	
	local scroll = vgui.Create( "DScrollPanel", base )
	scroll:Dock( FILL )
	
	for i = 1, 3 do
		timer.Simple( i, function()
			local item = vgui.Create( "DPanel", scroll )
			item:Dock( TOP )
			item:SetSize( 0, 70 )
			timer.Simple( 3, function()
				item:Remove()
			end )	
		end )
	end
	
end )
