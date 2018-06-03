surface.CreateFont( "HUDFont", { font = "Lucida Console", size = ScreenScale( 20 ), weight = 700 } )
surface.CreateFont( "AmmoFont", { font = "Lucida Console", size = ScreenScale( 40 ), weight = 700 } )

hook.Add( "HUDPaint", "DrawSomeText", function()

	local name = "Name: " .. LocalPlayer():Nick()
	local money = "Money: " .. DarkRP.formatMoney( LocalPlayer():getDarkRPVar( "money" ) )
	local salary = "Salary: " .. DarkRP.formatMoney( LocalPlayer():getDarkRPVar( "salary" ) )
	local job = "Job: " .. team.GetName( LocalPlayer():Team() )
	local str = name .. "\n" .. money .. "\n" .. salary .. "\n" .. job
	draw.DrawText( str, "HUDFont", ScrH() * 0.2, ScrW() * 0.03, Color( 255, 216, 68 ) )

	if LocalPlayer():GetActiveWeapon():Clip1() != -1 then
		local ammo = LocalPlayer():GetActiveWeapon():Clip1() .. "/" .. LocalPlayer():GetAmmoCount( LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType() )
		draw.SimpleText( ammo, "AmmoFont", ScrH() * 1.28, ScrW() * 0.52, Color( 190, 194, 68 ) )
	end

end )
