local lag = 2
local lagPos = Vector( 0, 0, 0 )
local lagAng = Angle( 0, 0, 0 )

hook.Add( "CalcView", "Lag", function( ply, pos, ang )
	if math.random( lag ) == 1 then
		lagPos = origin
		lagAng = angles
	end
	return { origin = lagPos, angles = lagAng }
end )
