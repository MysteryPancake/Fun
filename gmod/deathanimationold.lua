CreateConVar( "deathanimation_enabled", "1", { FCVAR_CHEAT, FCVAR_REPLICATED, FCVAR_NOTIFY }, "Sets whether a death animation should play when a player dies." )
local enabled = GetConVar( "deathanimation_enabled" )

hook.Add( "PlayerDeath", "DeathAnimation", function( victim, inflictor, attacker )
	
	if not enabled:GetBool() then return end --If the convar isn't enabled then skip all this (also, you might want to check if the player fell or exploded, because both look unrealistic if this animation is played)
	
	victim.LetRespawn = false -- Don't let the player respawn until we're done with the animation
	victim:GetRagdollEntity():Remove() -- Remove the ragdoll of the player
	
	local FakePly = ents.Create( "base_gmodentity" )

	FakePly:SetModel( victim:GetModel() )
	FakePly:SetPos( victim:GetPos() )
	FakePly:SetAngles( victim:GetAngles() )
	FakePly:Spawn()

	local seq = "death_0" .. math.random( 4 )

	FakePly:SetSequence( FakePly:LookupSequence( seq ) ) --Set a random death animation
	FakePly:SetPlaybackRate( 1 )
	FakePly.AutomaticFrameAdvance = true -- Auto advance the animation
	
	function FakePly:Think() -- This makes it actually play
		self:NextThink( CurTime() )
		return true
	end
	
	timer.Simple( FakePly:SequenceDuration( seq ), function() -- Or however long the sequence goes for before a ragdoll is spawned in place

		local Rag = ents.Create( "prop_ragdoll" )

		Rag:SetModel( victim:GetModel() )
		Rag:SetPos( victim:GetPos() )
		Rag:SetAngles( victim:GetAngles() )

		FakePly:Remove()

		-- for i = 0, Rag:GetBoneCount() - 1 do -- Doesn't work since SetBonePosition is clientside (THIS NEEDS FIXING)
		--	local vec, ang = victim:GetBonePosition( i )
		--	Rag:SetBonePosition( i, vec, ang )
		-- end

		Rag:Spawn()

		victim.Ragdoll = Rag
		victim.LetRespawn = true
	end )
	
end )

hook.Add( "PlayerDeathThink", "DeathAnimationThink", function( ply )
	if enabled:GetBool() and not ply.LetRespawn then return false end -- Don't let them respawn!
end )

hook.Add( "PlayerSpawn", "DeathAnimationRemoveRagdoll", function( ply )
	if ply.Ragdoll ~= nil then
		ply.Ragdoll:Remove() -- Remove the ragdoll we spawned
		ply.Ragdoll = nil
	end
end )
