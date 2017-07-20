TOOL.Category = "Construction"
TOOL.Name = "#Demolisher"

if ( CLIENT ) then
	language.Add( "tool.demolisher.name", "Demolisher" )
	language.Add( "tool.demolisher.desc", "Breaks everything" )
	language.Add( "tool.demolisher.0", "Left click to demolish" )
end

function TOOL:LeftClick( trace )

	if IsValid( trace.Entity ) then

		local class = trace.Entity:GetClass()

		if class == "func_breakable" or class == "func_physbox" or class == "prop_physics" then
			trace.Entity:Fire( "Break" )
		elseif class == "npc_turret_floor" or class == "npc_helicopter" then
			trace.Entity:Fire( "SelfDestruct" )
		elseif class == "npc_rollermine" then
			trace.Entity:Fire( "InteractivePowerDown" )
		else
			trace.Entity:TakeDamage( trace.Entity:Health() )
		end

	end

	return true

end

function TOOL.BuildCPanel( CPanel )
	CPanel:AddControl( "Header", { Text = "#tool.demolisher.name", Description = "#tool.demolisher.desc" } )
	CPanel:AddControl( "Label", { Text = "#tool.demolisher.0" } )
end
