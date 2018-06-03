-- CLIENTSIDE:
local frame

net.Receive( "f4menu", function()
    if not IsValid( frame ) then
        local frame = vgui.Create( "DFrame" )
        frame:SetTitle( "DarkRP Menu" )
        frame:SetSize( ScrW() * 0.75, ScrH() * 0.75 )
        frame:Center()
        frame:MakePopup()
    end
end )

-- SERVERSIDE:
util.AddNetworkString( "f4menu" )

hook.Add( "ShowSpare2", "F4MenuHook", function( ply )
    net.Start( "f4menu" )
    net.Send( ply )
end )
