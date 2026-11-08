CreateClientConVar( "secondperson", "0", true, false )

hook.Add( "CalcView", "FirstPersonBody", function( ply, pos, ang, fov )
	if ply:GetViewEntity() ~= ply or !tobool( GetConVarNumber( 'secondperson' ) ) then return end
	local eyes = ply:GetAttachment( ply:LookupAttachment( "eyes" ) )
	return { origin = eyes.Pos,
	--angles = eyes.Ang,
	angles = ang,
	fov = fov,
	drawviewer = true }
end )