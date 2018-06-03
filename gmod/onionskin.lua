local alpha = 150

hook.Add( "DrawOverlay", "OnionSkin", function()
	local pics = file.Find( "screenshots/*", "GAME", "dateasc" )
	surface.SetDrawColor( 255, 255, 255, alpha )
	local mat = Material( "../screenshots/" .. pics[ #pics ] )
	if mat:IsError() then
		surface.SetMaterial( Material( "../screenshots/" .. pics[ #pics - 1 ] ) )
	else
		surface.SetMaterial( mat )
	end
	surface.DrawTexturedRect( 0, 0, ScrW(), ScrH() )
end )

hook.Add( "KeyPress", "ToggleOnionSkin", function( _, key )
	if key == IN_RELOAD then
		alpha = alpha == 150 and 0 or 150
	end
end )
