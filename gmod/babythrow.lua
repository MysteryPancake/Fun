function SWEP:ThrowBaby( mdl )

	if CLIENT then return end -- If we are the client this is as much as we want to do
	
	for i = 1, 3 do
	
		local ent = ents.Create( "prop_physics" ) -- Create a prop_physics entity

		if not IsValid( ent ) then return end -- Always make sure that created entities are actually created
		
		ent:SetModel( mdl ) -- Set the entity's model to the passed model
		
		ent:SetPos( self.Owner:EyePos() + ( self.Owner:GetAimVector() * 32 ) + ( i * 4 ) ) -- Set pos to player's eye position + i * 4 units forward
		ent:SetAngles( self.Owner:EyeAngles() ) -- Set angles to player's eye angles
		ent:Spawn() -- Then spawn it

		local phys = ent:GetPhysicsObject()
		phys:ApplyForceCenter( self.Owner:GetAimVector() * 100000 ) -- Now we apply the force

		cleanup.Add( self.Owner, "props", ent ) -- Assuming it is sandbox, adding this to cleanup and undo lists

		undo.Create( "Thrown_Baby" )
			undo.AddEntity( ent )
			undo.SetPlayer( self.Owner )
		undo.Finish()

	end

end
