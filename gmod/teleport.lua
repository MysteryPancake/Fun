TOOL.Category = "Poser"
TOOL.Name = "#Teleporter"
TOOL.Command = nil
TOOL.ConfigName = ""

if CLIENT then
	language.Add( "tool.stupidteleporter.name", "Teleporting Tool" )
	language.Add( "tool.stupidteleporter.desc", "Teleports yourself" )
	language.Add( "tool.stupidteleporter.0", "Left click to teleport. Right click does nothing." )
end

function TOOL:LeftClick( trace )
	self:GetOwner():SetPos( trace.HitPos )
	return true
end

function TOOL:RightClick( trace )
	return false
end
