AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "Slot Machine"
ENT.Author = "MysteryPancake"
ENT.Category = "Illegal Gambling"
ENT.Purpose = "Losing money fast"
ENT.Instructions = "Press USE to make it spin"

ENT.Spawnable = true
ENT.AdminOnly = true

function ENT:SetupDataTables()

	self:NetworkVar( "Vector", 0, "Slots" )
	self:NetworkVar( "Bool", 1, "Spinning" )
	
end
	
function ENT:RandomizeSlots()

	self:SetSlots( Vector( math.random( 3 ), math.random( 3 ), math.random( 3 ) ) )
	
end
	
if SERVER then

	function ENT:SpawnFunction( ply, tr, ClassName )

		if !tr.Hit then return end

		local SpawnPos = tr.HitPos + tr.HitNormal * 50

		local ent = ents.Create( ClassName )
		ent:SetPos( SpawnPos )
		ent:Spawn()
		ent:Activate()

		return ent

	end

	function ENT:Initialize()

		self:SetModel( "models/props_interiors/VendingMachineSoda01a.mdl" )
		
		self:PhysicsInit( SOLID_VPHYSICS )
		self:SetMoveType( MOVETYPE_VPHYSICS )
		self:PhysWake()
		
		self:SetUseType( SIMPLE_USE )

	end
	
	function ENT:HasWon()
	
		local slots = self:GetSlots()
		if slots.x == slots.y and slots.x == slots.z and slots.y == slots.z then
			return true
		end
		
		return false
		
	end
	
	function ENT:GivePrize()
	
		local can = ents.Create( "prop_physics" )
		can:SetModel( "models/props_junk/PopCan01a.mdl" )
		can:SetPos( self:LocalToWorld( Vector( 18, -5, -27 ) ) )
		can:Spawn()
		
	end
	
	function ENT:Use( activator, caller )
	
		if not self:GetSpinning() then
		
			self:SetSpinning( true )
			
			timer.Simple( 1, function()
			
				self:SetSpinning( false )
				self:RandomizeSlots()
				
				if self:HasWon() then
					self:GivePrize()
				end
				
			end )
			
		end
		
	end

end

if CLIENT then

	local icons = {
		[ 0 ] = Material( "icon16/cross.png" ),
		[ 1 ] = Material( "icon16/coins.png" ),
		[ 2 ] = Material( "icon16/star.png" ),
		[ 3 ] = Material( "icon16/heart.png" )
	}
	
	local function DrawSlot( x, y, w, h, mat )
	
		surface.SetDrawColor( 0, 0, 0 )
		surface.DrawRect( x, y, w, h )
		
		surface.SetDrawColor( 255, 255, 255 )
		surface.DrawRect( x + 5, y + 5, w - 10, h - 10 )
		
		surface.SetMaterial( mat )
		surface.DrawTexturedRect( x + 10, y + 10, w - 20, h - 20 )
		
	end
	
	function ENT:Draw()

		self:DrawModel()
		
		if self:GetSpinning() then self:RandomizeSlots() end
		
		local ang = self:GetAngles()
		ang:RotateAroundAxis( ang:Forward(), 90 )
		ang:RotateAroundAxis( ang:Right(), -90 )
		
		cam.Start3D2D( self:GetPos() + ang:Up() * 17.4 + ang:Forward() * 16, ang, 0.2 )
		
			local slots = self:GetSlots()
			for i = 1, 3 do
				DrawSlot( 0, i * 55, 50, 50, icons[ slots[ i ] ] )
			end
			
		cam.End3D2D()
		
	end

end
