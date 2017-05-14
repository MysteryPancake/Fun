hook.Add( "PhysgunPickup", "PhysgunKill", function( ply, ent )
	ent:TakeDamage( ent:Health() )
end )
