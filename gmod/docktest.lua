local frame = vgui.Create( "DFrame" )
frame:SetTitle( "Dock Test" )
frame:SetSize( ScrW() - 100, ScrH() - 100 )
frame:Center()
frame:MakePopup()

for _ = 0, 10 do
	
	local panel = vgui.Create( "Panel", frame )
	panel:Dock( TOP )

	local label = vgui.Create( "DLabel", panel )
	label:Dock( LEFT )
	label:SetText( "Your name" )

	local box = vgui.Create( "DTextEntry", panel )
	box:Dock( FILL )

end
