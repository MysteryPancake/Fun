hook.Add( "Think", "AimBot", function()
	local ply = LocalPlayer()
	local trace = ply:GetEyeTrace()
	local target = trace.Entity
	if IsValid( target ) then
		local eyes = target:GetAttachment( target:LookupAttachment( "eyes" ) )
		if eyes then
			ply:SetEyeAngles( ( eyes.Pos - ply:GetShootPos() ):Angle() )
		end
	end
end )
