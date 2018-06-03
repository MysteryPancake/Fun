if SERVER then
    util.AddNetworkString( "DeathMenu" )
    hook.Add( "PlayerDeath", "blah", function( victim )
        net.Start( "DeathMenu" )
        net.Send( victim )
    end )
end

if CLIENT then
    net.Receive( "DeathMenu", function()
        local frame = vgui.Create( "DFrame" )
        frame:SetSize( ScrW() * 0.9, ScrH() * 0.9 )
        frame:Center()
        frame:MakePopup()
    end )
end
