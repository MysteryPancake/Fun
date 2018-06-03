local vtf = Material( "dev/dev_measurecrate01" ) -- This is a VMT / VTF

hook.Add( "HUDPaint", "VTFTest", function()
	surface.SetMaterial( vtf )
	surface.SetDrawColor( 255, 255, 255 )
	surface.DrawTexturedRect( 0, 0, ScrW(), ScrH() )
end )
