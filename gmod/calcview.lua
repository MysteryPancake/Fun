hook.Add( "CalcView", "blah", function( ply, pos, angles, fov )

	ply.LastViewPosition = ply.LastViewPosition or pos

	local view = {}

	local MouseX, MouseY = gui.MousePos()
	local dist = 350
	
	--Make the origin of the mouse the center of the screen
	local NormX = ( 0.5 - MouseX / ScrW() ) / 0.5
	local NormY = ( 0.5 - MouseY / ScrH() ) / 0.5
	
	local center = ply:GetPos() + Vector( NormY * dist * 0.4, NormX * dist * 0.4, 75 )

	ply.LastViewPosition = LerpVector( math.pow( math.max( center:Distance( ply.LastViewPosition ), 300) / 300, 2 )  * FrameTime() * ( ply:GetVelocity():Length() / 50 + 1.5 ), ply.LastViewPosition, center )
	
	view.origin = ply.LastViewPosition - angles:Forward() * dist
	view.angles = Angle( angles.p, angles.y, angles.r )
	
	return view
	
end )
