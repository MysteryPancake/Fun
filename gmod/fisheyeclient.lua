function SWEP:DrawHUD()
    if self.Owner:IsInvisible() then -- change this to whatever you use to check if they're invisible
        DrawMaterialOverlay( "models/props_c17/fisheyelens", -0.06 ) -- change this to whatever effect
    end
end
