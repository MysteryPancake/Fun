local panel = vgui.Create( "DFrame" )
panel:SetSize( ScrW(), ScrH() )
panel:Center()
panel:MakePopup()

local icon = vgui.Create( "DAdjustableModelPanel", panel )
icon:Dock( FILL )
icon:SetModel( "models/props_c17/oildrum001.mdl" ) -- doesn't matter
function icon:DrawModel()
    self.Entity:DrawModel() -- doesn't matter
    error()
end
