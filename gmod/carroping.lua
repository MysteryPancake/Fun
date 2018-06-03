hook.Add( "CanTool", "DisableCarRoping", function( ply, tr, tool )
	if tool == "rope" and IsValid( tr.Entity ) and tr.Entity:IsVehicle() then
		return false
	end
end )
