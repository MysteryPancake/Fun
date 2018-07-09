hook.Add( "PlayerSay", "GiveFrag", function( ply, text )
    if ply:IsAdmin() and text == "!gg *" then
        for _, v in ipairs( player.GetHumans() ) do
            v:Give( "weapon_frag" )
            v:GiveAmmo( 1, "Grenade" )
        end
        return ""
    end
end )
