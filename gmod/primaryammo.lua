local wep = v:GetActiveWeapon()
local ammo = wep:GetPrimaryAmmoType()
v:GiveAmmo( 10, ammo, true )
