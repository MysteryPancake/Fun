hook.Add( "CalcView", "SideDown", function( ply, pos, ang )

	local view = {}
	view.origin = pos + Vector( -100, 0, 100 )
	view.angles = Angle( 45, 0, 0 )
	view.drawviewer = true

	return view

end )
