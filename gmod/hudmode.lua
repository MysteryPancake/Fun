local hudmode = CreateClientConVar( "hudmode", "1", true, false )

hook.Add( "HUDPaint", "blah", function()
    if hudmode:GetBool() then
        -- draw health hud
    else
        -- draw armor hud
    end
end )
