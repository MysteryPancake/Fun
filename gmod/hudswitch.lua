local hud = "health"

hook.Add( "HUDPaint", "blah", function()
    if hud == "health" then
        -- draw health hud
    elseif hud == "armor"
        -- draw armor hud
    end
end )
