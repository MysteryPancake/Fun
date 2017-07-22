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

ENT.Icons = {
	[ 0 ] = Material( "icon16/cross.png" ),
	[ 1 ] = Material( "icon16/accept.png" ),
	[ 2 ] = Material( "icon16/award_star_bronze_1.png" ),
	[ 3 ] = Material( "icon16/award_star_bronze_2.png" ),
	[ 4 ] = Material( "icon16/award_star_bronze_3.png" ),
	[ 5 ] = Material( "icon16/award_star_gold_1.png" ),
	[ 6 ] = Material( "icon16/award_star_gold_2.png" ),
	[ 7 ] = Material( "icon16/award_star_gold_3.png" ),
	[ 8 ] = Material( "icon16/award_star_silver_1.png" ),
	[ 9 ] = Material( "icon16/award_star_silver_2.png" ),
	[ 10 ] = Material( "icon16/award_star_silver_3.png" ),
	[ 11 ] = Material( "icon16/bell.png" ),
	[ 12 ] = Material( "icon16/briefcase.png" ),
	[ 13 ] = Material( "icon16/cake.png" ),
	[ 14 ] = Material( "icon16/coins.png" ),
	[ 15 ] = Material( "icon16/creditcards.png" ),
	[ 16 ] = Material( "icon16/drink.png" ),
	[ 17 ] = Material( "icon16/emoticon_grin.png" ),
	[ 18 ] = Material( "icon16/emoticon_happy.png" ),
	[ 19 ] = Material( "icon16/emoticon_smile.png" ),
	[ 20 ] = Material( "icon16/emoticon_surprised.png" ),
	[ 21 ] = Material( "icon16/emoticon_wink.png" ),
	[ 22 ] = Material( "icon16/heart.png" ),
	[ 23 ] = Material( "icon16/key.png" ),
	[ 24 ] = Material( "icon16/lightning.png" ),
	[ 25 ] = Material( "icon16/lock_open.png" ),
	[ 26 ] = Material( "icon16/medal_bronze_1.png" ),
	[ 27 ] = Material( "icon16/medal_bronze_2.png" ),
	[ 28 ] = Material( "icon16/medal_bronze_3.png" ),
	[ 29 ] = Material( "icon16/medal_gold_1.png" ),
	[ 30 ] = Material( "icon16/medal_gold_2.png" ),
	[ 31 ] = Material( "icon16/medal_gold_3.png" ),
	[ 32 ] = Material( "icon16/medal_silver_1.png" ),
	[ 33 ] = Material( "icon16/medal_silver_2.png" ),
	[ 34 ] = Material( "icon16/medal_silver_3.png" ),
	[ 35 ] = Material( "icon16/money.png" ),
	[ 36 ] = Material( "icon16/money_dollar.png" ),
	[ 37 ] = Material( "icon16/money_euro.png" ),
	[ 38 ] = Material( "icon16/money_pound.png" ),
	[ 39 ] = Material( "icon16/money_yen.png" ),
	[ 40 ] = Material( "icon16/rainbow.png" ),
	[ 41 ] = Material( "icon16/ruby.png" ),
	[ 42 ] = Material( "icon16/shield.png" ),
	[ 43 ] = Material( "icon16/star.png" ),
	[ 44 ] = Material( "icon16/tick.png" ),
	[ 45 ] = Material( "icon16/wand.png" ),
}

function ENT:SetupDataTables()
	self:NetworkVar( "Vector", 0, "Slots" )
	self:NetworkVar( "Bool", 0, "Spinning" )
end

function ENT:GetRandomIcons()
	return Vector( math.random( #self.Icons ), math.random( #self.Icons ), math.random( #self.Icons ) )
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
		return slots[ 1 ] == slots[ 2 ] and slots[ 2 ] == slots[ 3 ]
	end
	
	function ENT:GivePrize( mdl )
		local can = ents.Create( "prop_physics" )
		can:SetModel( mdl )
		can:SetPos( self:LocalToWorld( Vector( 18, -5, -27 ) ) )
		can:Spawn()
	end
	
	function ENT:Use( activator, caller )
	
		if not self:GetSpinning() then
		
			self:EmitSound( "garrysmod/content_downloaded.wav" )
			
			self:SetSpinning( true )
			
			timer.Simple( 1, function()
				
				self:SetSpinning( false )
				self:SetSlots( self:GetRandomIcons() )
				
				self:EmitSound( "garrysmod/balloon_pop_cute.wav" )
				
				if self:HasWon() then
					self:GivePrize( "models/props_junk/PopCan01a.mdl" )
				end
			
			end )
		
		end
	
	end

end

if CLIENT then
	
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
		
		local slots = self:GetSpinning() and self:GetRandomIcons() or self:GetSlots()
		
		local ang = self:GetAngles()
		ang:RotateAroundAxis( ang:Forward(), 90 )
		ang:RotateAroundAxis( ang:Right(), -90 )
	
		cam.Start3D2D( self:GetPos() + ang:Up() * 17.4 + ang:Forward() * 16, ang, 0.2 )
			for i = 1, 3 do
				DrawSlot( 0, i * 55, 50, 50, self.Icons[ slots[ i ] ] )
			end
		cam.End3D2D()
		
	end

end
