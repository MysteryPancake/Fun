hook.Add( "EntityTakeDamage", "FunKill", function( target, dmg )
	dmg:AddDamage( target:Health() )
	dmg:SetDamageForce( dmg:GetDamageForce() + dmg:GetAttacker():GetForward() * 9999 + Vector( 0, 0, 9999 ) )
end )
