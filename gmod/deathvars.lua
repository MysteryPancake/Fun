if SERVER then
    util.AddNetworkString( "DeathMenu" )
    hook.Add( "PlayerDeath", "blah", function( victim, inflictor, attacker )
        net.Start( "DeathMenu" )
        net.WriteEntity( inflictor )
        net.WriteEntity( attacker )
        net.Send( victim )
    end )
end

if CLIENT then
    net.Receive( "DeathMenu", function()
        local victim = LocalPlayer()
        local inflictor = net.ReadEntity()
        local attacker = net.ReadEntity()
        -- Do something with victim, inflictor and attacker
    end )
end
