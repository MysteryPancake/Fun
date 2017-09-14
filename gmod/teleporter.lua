TOOL.Category = "Poser"
TOOL.Name = "#Teleporter"

if CLIENT then
	language.Add( "tool.teleporter.name", "Teleporter" )
	language.Add( "tool.teleporter.desc", "Teleport yourself" )
	language.Add( "tool.teleporter.0", "Left click to teleport" )
end

function TOOL:LeftClick( trace )
	self:GetOwner():SetPos( trace.HitPos )
	return true
end

function TOOL:DrawToolScreen( w, h )
	render.RenderView( {
		x = 0, y = 0,
		w = w, h = h,
		origin = self:GetOwner():GetEyeTrace().HitPos + self:GetOwner():WorldToLocal( self:GetOwner():EyePos() ),
		angles = self:GetOwner():EyeAngles(),
		dopostprocess = true, drawviewmodel = false
	} )
end

function TOOL.BuildCPanel( CPanel )
	CPanel:AddControl( "Header", { Text = "#tool.teleporter.name", Description = "#tool.teleporter.desc" } )
	CPanel:AddControl( "Label", { Text = "#tool.teleporter.0" } )
end
