surface.CreateFont( "HUDFont", { font = "Trebuchet MS", size = 15 } )

local function DrawHUDRectangle( x, y, w, h, bg, fg, innerW )

	surface.SetDrawColor( bg )
	surface.DrawRect( x, y, w, h )
	surface.SetDrawColor( fg )
	surface.DrawRect( x, y + h / 4, innerW * ( w - h / 4 ), h / 2 )

	draw.SimpleText( innerW * 100 .. "%", "HUDFont", x + w, y + h / 2, fg, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )

end

hook.Add( "HUDPaint", "blah", function()

	local background = Color( 0, 0, 0, 120 )

	local armorCol = Color( 0, 0, 150 )
	local armor = LocalPlayer():Armor() / 100
	DrawHUDRectangle( 0, ScrH() * 0.8, ScrW() * 0.3, ScrH() * 0.03, background, armorCol, armor )

	local healthCol = Color( 150, 0, 0 )
	local health = LocalPlayer():Health() / LocalPlayer():GetMaxHealth()
	DrawHUDRectangle( 0, ScrH() * 0.85, ScrW() * 0.3, ScrH() * 0.03, background, healthCol, health )

end )
