hook.Add( "PlayerSay", "GiveFrag", function( ply, txt )
    if ply:IsAdmin() and txt == "!gg *" then
        for _, v in ipairs( player.GetHumans() ) do
            v:Give( "weapon_frag" )
            v:GiveAmmo( 1, "Grenade" )
        end
        return ""
    end
end )
