local avatar

hook.Add( "HUDPaint", "MyNameJeff", function()

	local ply = LocalPlayer()

	local health = math.Clamp( ply:Health() / ply:GetMaxHealth(), 0, 1 )
	surface.SetDrawColor( 13, 13, 13, 275 )
	surface.DrawRect( 5, 925, 310, 150 )
	surface.SetDrawColor( 40, 40, 40 )
	surface.DrawRect( 8, ScrH() - 43, 304, 34 )
	surface.SetDrawColor( 255, 0, 0 )
	surface.DrawRect( 10, ScrH() - 41, health * 900, 30 )

	local armor = ply:Armor()
	surface.SetDrawColor( 40, 40, 40 )
	surface.DrawRect( 8, ScrH() - 80, 304, 33 )
	surface.SetDrawColor( 0, 0, 255 )
	surface.DrawRect( 10, ScrH() - 78, armor * 3, 30 )

	if not IsValid( avatar ) then
		avatar = vgui.Create( "AvatarImage" )
		avatar:SetSize( 64, 64 )
		avatar:SetPos( 10, 930 )
		avatar:SetPlayer( ply, 64 )
	end

	draw.DrawText( ply:Nick(), "DarkRPHUD2", ScrW() - 1830, ScrH() - 132, color_white )

	surface.SetDrawColor( 13, 13, 13, 275 )
	surface.DrawRect( 5, 882, 310, 35 )
	draw.DrawText( "$" .. ply:getDarkRPVar( "money" ), "DarkRPHUD2", ScrW() - 1915, ScrH() - 191, color_white )

end )
