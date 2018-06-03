-- CLIENTSIDE:
hook.Add( "HUDPaint", "InvisibleEffect", function()
    if self.Owner:IsInvisible() then -- change this to whatever you use to check if they're invisible
        DrawMaterialOverlay( "models/props_c17/fisheyelens", -0.06 ) -- change this to whatever effect
    end
end )

-- SERVERSIDE:
function SWEP:PrimaryAttack()
    self.Owner:SetInvisible( true ) -- change this to whatever you do to set if they're invisible
end
