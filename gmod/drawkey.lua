hook.Add( "HUDPaint", "DrawKeys", function()
	
	local function DrawKey( enum, key, x, y, w, h, key_color, key_color_if_pressed, key_text_color, font, outline_enabled, outline_color ) -- Helper function
		
		if input.IsKeyDown( enum ) then
			surface.SetDrawColor( key_color_if_pressed )
		else
			surface.SetDrawColor( key_color )
		end
		surface.DrawRect( x, y, w, h )
		
		if outline_enabled then
			surface.SetDrawColor( outline_color )
			surface.DrawOutlinedRect( x, y, w, h )
		end
		
		surface.SetTextColor( key_text_color )
		surface.SetFont( font )
		local textw, texth = surface.GetTextSize( key )
		surface.SetTextPos( x + ( w / 2 ) - ( textw / 2 ), y + ( h / 2 ) - ( texth / 2 ) ) -- This just centers the key
		surface.DrawText( key )
		
	end
	
	DrawKey( KEY_W, "W", ScrW() - 55, ScrH() - 55, 50, 50, Color( 255, 255, 255 ), Color( 255, 0, 0 ), Color( 0, 0, 0 ), "DermaLarge", true, Color( 0, 0, 0 ) ) -- Draws 'W' in the bottom-right corner
	
end )
