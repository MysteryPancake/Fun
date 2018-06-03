local healers = {
    [ "models/props_junk/sawblade001a.mdl" ] = 100, -- Pressing E on a sawblade gives 100 health
    [ "models/props_c17/oildrum001_explosive.mdl" ] = 10000, -- Pressing E on an explosive barrel gives 10000 health
}

hook.Add( "PlayerUse", "blah", function( ply, ent )
    if IsValid( ent ) and ent:CreatedByMap() then
        local health = healers[ ent:GetModel() ]
        if health then
            ply:SetHealth( ply:Health() + health )
            ent:Remove()
        end
    end
end )
