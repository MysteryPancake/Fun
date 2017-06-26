hook.Add( "CalcView", "FOVTest", function( ply, pos, ang, fov )
	return { fov = fov + ply:GetVelocity():Length() * 0.05 }
end )
