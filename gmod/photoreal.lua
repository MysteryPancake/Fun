-- Use this code: https://facepunch.com/showthread.php?t=1562320&p=52204958#post52204958

local pos, ang, mat

hook.Add( "PostDrawOpaqueRenderables", "PhotoReal", function()
	if mat then
		cam.Start3D2D( pos+ang:Forward()*(math.sqrt(ScrW()*ScrH())/2)+ang:Right()*-(ScrW()/2)+ang:Up()*(ScrH()/2), Angle(0,ang.y-90,-ang.p+90), 1 )
			surface.SetMaterial( mat )
			surface.SetDrawColor( 255, 255, 255, 255 )
			surface.DrawTexturedRect( 0, 0, ScrW(), ScrH() )
		cam.End3D2D()
	end
end )

concommand.Add( "PhotoReal", function()

	pos = EyePos()
	ang = EyeAngles()
	
	local data = render.Capture( {
		x = 0, y = 0,
		w = ScrW(), h = ScrH(),
		format = "jpeg",
		quality = 100,
	} )
	
	file.Write( "render.jpg", data )
	
	RunConsoleCommand( "mat_reloadmaterial", "data/render" )
	
	mat = Material( "data/render.jpg" )
	
end )
