hook.Add( "HUDPaint", "SpectateHUD", function()
    if LocalPlayer():GetObserverMode() ~= OBS_MODE_NONE then
        -- Draw spectator HUD
    end
end )
