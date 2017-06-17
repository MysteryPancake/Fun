local past = {}

hook.Add( "CalcView", "PastView", function( ply, pos, ang, fov )
	while #past < 100 do
		table.insert( past, { origin = pos, angles = ang, fov = fov, drawviewer = true } )
	end
	table.remove( past, 1 )
	return past[ 1 ]
end )
