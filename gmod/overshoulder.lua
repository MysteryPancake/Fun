local function OverShoulder( ply, pos, angles, fov )

	if input.IsMouseDown( MOUSE_RIGHT ) then

		local view = {}
		view.origin = pos - ( angles:Forward() * 30 + angles:Right() * -30 )
		view.angles = angles
		view.fov = fov
		view.drawviewer = true

		return view

	end
	
end

hook.Add( "CalcView", "OverShoulder", OverShoulder )
