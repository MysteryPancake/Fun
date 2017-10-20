hook.Add( "DoAnimationEvent", "Flowbar", function( ply, event )

	if event ~= PLAYERANIMEVENT_ATTACK_PRIMARY then return end

	local vm = ply:GetViewModel()
	local seq = vm:GetSequence()
	local act = vm:GetSequenceActivity( seq )

	if act == ACT_VM_HITCENTER then
		local miss = vm:SelectWeightedSequence( ACT_VM_MISSCENTER )
		vm:SendViewModelMatchingSequence( miss )
	end

end )
