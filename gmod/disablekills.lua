local disable = true

hook.Add( "DrawDeathNotice", "DisableKills", function()
    if disable then
        return 0, 0
    end
end )
