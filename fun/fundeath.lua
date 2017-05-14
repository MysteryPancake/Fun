hook.Add( "EntityTakeDamage", "FunDeath", function( target, dmg )
	dmg:ScaleDamage( 99999999999999999999999999999999999999999999999 )
	dmg:SetDamageForce( dmg:GetAttacker():GetForward() * 9999 + Vector( 0, 0, 9999 ) )
end )
