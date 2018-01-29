hook.Add( "CalcView", "TopDown", function( ply, pos, ang )

	local view = {}
	view.origin = pos + Vector( 0, 0, 100 )
	view.angles = Angle( 90, ang.y, 0 )
	view.drawviewer = true

	return view

end )
