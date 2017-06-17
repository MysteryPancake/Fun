local past = {}

hook.Add( "CalcView", "Test", function( ply, pos, ang )
	while #past < 100 do
		table.insert( past, { origin = pos, angles = ang } )
	end
	table.remove( past, 1 )
	return past[1]
end )
