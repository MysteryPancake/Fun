local mat = Material( "some/image.png" )

hook.Add( "HUDPaint", "blah", function()
    surface.SetMaterial( mat )
    surface.SetDrawColor( 255, 255, 255 )
    surface.DrawTexturedRect( 0, 0, ScrW(), ScrH() )
end )
