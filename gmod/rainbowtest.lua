local function DrawRainbowText( multiplier, str, font, x, y, shift )
	
	surface.SetFont( font )
	
	for i = 1, #str do
		surface.SetTextColor( HSVToColor( ( i + shift ) * multiplier % 360, 1, 1 ) )
		local w = surface.GetTextSize( string.sub( str, 1, i - 1 ) )
		surface.SetTextPos( x + w, y )
		surface.DrawText( string.sub( str, i, i ) )
	end
	
end

hook.Add( "HUDPaint", "Jeff", function()
	DrawRainbowText( 30, "My name is Jeff", "DermaLarge", 50, 50, CurTime() * 10)
end )
