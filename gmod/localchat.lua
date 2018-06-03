hook.Add( "OnPlayerChat", "HideMessage", function( ply )
    if LocalPlayer():GetPos():Distance( ply:GetPos() ) < 50 then -- Change 50 to whatever distance you want them to be in
        return true
    end
end )
