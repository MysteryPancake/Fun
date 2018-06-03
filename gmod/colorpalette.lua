local frame = vgui.Create( "DFrame" )
frame:SetSize( ScrW() - 100, ScrH() - 100 )
frame:Center()
frame:MakePopup()

local palette = vgui.Create( "DColorPalette", frame )
palette:Dock( FILL )

function palette:OnValueChanged( newcol )
	PrintTable( newcol )
end
