local Weapons = { [ "weapon_physgun" ] = true, [ "weapon_crowbar" ] = true }

if Weapons[ LocalPlayer():GetActiveWeapon():GetClass() ] then return end
