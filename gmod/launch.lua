if CLIENT then

	local drawTarget = false

	net.Receive( "DrawTarget", function()
		drawTarget = net.ReadBool()
	end )

	hook.Add( "PostDrawOpaqueRenderables", "target_draw", function()
		if drawTarget then
			render.SetColorMaterial()
			render.DrawSphere( LocalPlayer():GetPos(), 50, 30, 30, Color( 45, 230, 255, 100 ) )
		end
	end )

end

if SERVER then

	util.AddNetworkString( "DrawTarget" )

	local function launch( ply )
		ply:SetVelocity( Vector( 0, 0, 2000 ) )
		timer.Simple( 2, function()
			ply:SetVelocity( Vector( 0, 0, -40000 ) )
		end )
	end

	function SWEP:PrimaryAttack()
		net.Start( "DrawTarget" )
		net.WriteBool( true )
		net.Send( self.Owner )
		launch( self.Owner )
	end
	 
	function SWEP:Deploy()
		self.Owner.reduceDamage = true
		return true
	end
	 
	function SWEP:Holster()
		self.Owner.reduceDamage = false
		return true
	end

	hook.Add( "EntityTakeDamage", "ReduceFallDamage", function( target, dmginfo )
		if target:IsPlayer() and target.reduceDamage and dmginfo:IsFallDamage() then
			dmginfo:SetDamage( 0 )
		end
	end )

end
