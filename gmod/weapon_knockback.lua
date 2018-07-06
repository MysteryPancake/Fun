AddCSLuaFile()

SWEP.PrintName = "Knockback Gun"
SWEP.Author = "MysteryPancake"
SWEP.Purpose = "Knocks the player back whenever they shoot."

SWEP.Slot = 1
SWEP.SlotPos = 2

SWEP.Spawnable = true

SWEP.ViewModel = Model( "models/weapons/c_357.mdl" )
SWEP.WorldModel = Model( "models/weapons/w_357.mdl" )
SWEP.ViewModelFOV = 70

SWEP.UseHands = true

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.DrawAmmo = false
SWEP.AdminOnly = false

function SWEP:Initialize()

	self:SetHoldType( "revolver" )

end

function SWEP:PrimaryAttack()

	self:EmitSound( "Weapon_357.Single" )
	self:ShootBullet( 1000, 1, 0 )
	self.Owner:ViewPunch( Angle( -10, 0, 0 ) )

	if ( !SERVER ) then return end

	local forward = self.Owner:EyeAngles():Forward()
	self.Owner:SetVelocity( forward * -1000 )

end