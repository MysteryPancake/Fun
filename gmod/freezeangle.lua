hook.Add( "CalcView", "FreezeAngle", function( ply, pos, ang )
	local view = {}
	view.origin = pos
	view.angles = Angle( 0, 0, 0 )
	return view
end )
