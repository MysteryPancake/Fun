local assault = {
	[ "PRIMARY WEAPONS" ] = {
		{	
			name = "AK-12",
			weapon_tag = "tfa_ins2_ak12",
			starting_ammo = 0,
			ammo_type = "ar2",
			material = "icon16/gun.png",
			required_level = 0,
			desc = "Another bloody rifle.",
			model = "models/weapons/w_irifle.mdl"
		},
		{
			name = "ACR",
			weapon_tag = "tfa_ins2_acr",
			starting_ammo = 0,
			ammo_type = "ar2",
			material = "icon16/gun.png",
			required_level = 10,
			desc = "A powerful quick way to clean up a mess.",
			model = "models/weapons/w_smg1.mdl"
		},
		{
			name = "RFB",
			weapon_tag = "tfa_ins2_rfb",
			starting_ammo = 0,
			ammo_type = "ar2",
			material = "icon16/gun.png",
			required_level = 25,
			desc = "Good to hide under the bed.",
			model = "models/weapons/w_irifle.mdl"
		},
		{
			name = "SA80 (L85A2)",
			weapon_tag = "tfa_ins2_l85a2",
			starting_ammo = 0,
			ammo_type = "ar2",
			material = "icon16/gun.png",
			required_level = 46,
			desc = "A real game changer.",
			model = "models/weapons/w_smg1.mdl"
		},
		{
			name = "AKM",
			weapon_tag = "tfa_ins2_akz",
			starting_ammo = 0,
			ammo_type = "ar2",
			material = "icon16/gun.png",
			required_level = 37,
			desc = "A great home decoration.",
			model = "models/weapons/w_irifle.mdl"
		}
	},
	[ "SECONDARY WEAPONS" ] = {
		{
			name = "Glock P80",
			weapon_tag = "tfa_ins2_glock_p80",
			starting_ammo = 0,
			ammo_type = "Pistol",
			material = "icon16/gun.png",
			required_level = 0,
			desc = "Another bloody pistol.",
			model = "models/weapons/w_pistol.mdl"
		},
		{
			name = "USP Match",
			weapon_tag = "tfa_ins2_usp_match",
			starting_ammo = 0,
			ammo_type = "Pistol",
			material = "icon16/gun.png",
			required_level = 0,
			desc = "A gun for the ones you hate the most.",
			model = "models/weapons/w_crossbow.mdl"
		},
		{
			name = "Unica 6",
			weapon_tag = "tfa_ins2_mateba",
			starting_ammo = 0,
			ammo_type = "357",
			material = "icon16/gun.png",
			required_level = 16,
			desc = "A pretty good conversation starter.",
			model = "models/weapons/w_shotgun.mdl"
		},
		{
			name = "Desert Eagle",
			weapon_tag = "tfa_ins2_deagle",
			starting_ammo = 0,
			ammo_type = ".50",
			material = "icon16/gun.png",
			required_level = 43,
			desc = "The most powerful gun in the wild west.",
			model = "models/weapons/w_357.mdl"
		},
		{
			name = "Plasma Cutter",
			weapon_tag = "weapon_plasmacutter_bread",
			starting_ammo = 0,
			ammo_type = ".50",
			material = "icon16/gun.png",
			required_level = 55,
			desc = "I have no idea what this is supposed to be.",
			model = "models/weapons/w_physics.mdl"
		}
	},
	[ "TERTIARY WEAPONS" ] = {
		{
			name = "Smoke Grenade",
			weapon_tag = "weapon_ttt_smokegrenade",
			material = "icon16/bomb.png",
			required_level = 0,
			desc = "You can't kill what you can't see.",
			model = "models/weapons/w_grenade.mdl"
		},
		{
			name = "Flashbang Grenade",
			weapon_tag = "weapon_sh_flashbang",
			material = "icon16/bomb.png",
			required_level = 5,
			desc = "The flash usually signals you're going to die.",
			model = "models/weapons/w_grenade.mdl"
		},
		{
			name = "Frag Grenade",
			weapon_tag = "weapon_ttt_frag",
			material = "icon16/bomb.png",
			required_level = 5,
			desc = "Toss these across the map for an explosive time.",
			model = "models/weapons/w_slam.mdl"
		},
		{
			name = "RPG-7",
			weapon_tag = "tfa_ins2_rpg",
			material = "icon16/bomb.png",
			required_level = 27,
			desc = "A fun but inaccurate way to obliterate your enemies from a distance.",
			model = "models/weapons/w_rocket_launcher.mdl"
		}
	}
}

local frame = vgui.Create( "DFrame" )
frame:SetSize( ScrW() * 0.9, ScrH() * 0.9 )
frame:SetTitle( "Custom Games" )
frame:SetIcon( "icon16/gun.png" )
frame:Center()
frame:MakePopup()

function frame:Paint( w, h )
	Derma_DrawBackgroundBlur( self, self.m_fCreateTime )
	surface.SetDrawColor( 0, 0, 0, 200 )
	surface.DrawRect( 0, 0, w, h )
end

local sheet = vgui.Create( "DPropertySheet", frame )
sheet.tabScroller:SetOverlap( -8 )
sheet:Dock( FILL )

function sheet:Paint( w, h )
	surface.SetDrawColor( 0, 0, 0, 128 )
	surface.DrawRect( 0, 0, w, h )
	surface.SetDrawColor( 255, 255, 255, 16 )
	surface.DrawLine( 0, 0, w, 0 )
end

for k, v in pairs( assault ) do

	local panel = vgui.Create( "DColumnSheet", sheet )
	panel.Navigation:SetWidth( 256 )
	function panel:Paint( w, h )
		surface.SetDrawColor( 0, 0, 0 )
		surface.DrawRect( 0, 0, self.Navigation:GetWide() + 20, h )
	end

	for _, wep in pairs( v ) do

		local right = vgui.Create( "DScrollPanel", panel )
		right.pnlCanvas:DockPadding( 8, 8, 8, 0 )
		right:Dock( FILL )

		local title = vgui.Create( "DLabel", right )
		title:SetPaintBackgroundEnabled( true )
		title:SetTextColor( Color( 0, 0, 0 ) )
		title:SetFont( "DermaLarge" )
		title:SetText( wep.name )
		title:Dock( TOP )

		local desc = vgui.Create( "DLabel", right )
		desc:SetFont( "HudHintTextLarge" )
		desc:SetText( wep.desc )
		desc:Dock( TOP )

		local model = vgui.Create( "DModelPanel", right )
		model:SetModel( wep.model )
		model:Dock( TOP )
		model:SetHeight( 512 )

		local mn, mx = model.Entity:GetRenderBounds()
		local size = 0
		size = math.max( size, math.abs( mn.x ) + math.abs( mx.x ) )
		size = math.max( size, math.abs( mn.y ) + math.abs( mx.y ) )
		size = math.max( size, math.abs( mn.z ) + math.abs( mx.z ) )
		model:SetFOV( 45 )
		model:SetCamPos( Vector( size, size, size ) )
		model:SetLookAt( ( mn + mx ) * 0.5 )

		local level = vgui.Create( "DLabel", right )
		level:SetText( "Required Level: " .. wep.required_level )
		level:SetFont( "HudHintTextLarge" )
		level:Dock( TOP )

		local ammo = vgui.Create( "DLabel", right )
		ammo:SetText( "Ammo Type: " .. ( wep.ammo_type or "Unknown" ) )
		ammo:SetFont( "HudHintTextLarge" )
		ammo:Dock( TOP )

		local starting = vgui.Create( "DLabel", right )
		starting:SetText( "Starting Ammo: " .. ( wep.starting_ammo or 0 ) )
		starting:SetFont( "HudHintTextLarge" )
		starting:Dock( TOP )

		panel:AddSheet( wep.name, right, wep.material )

	end

	for _, v in ipairs( panel.Items ) do

		v.Button:SetHeight( 64 )
		v.Button:DockMargin( 0, 0, 0, 8 )
		v.Button:SetTextColor( Color( 255, 255, 255 ) )

		function v.Button:Paint( w, h )
			if panel.ActiveButton == self then
				surface.SetDrawColor( 255, 255, 255, 8 )
			else
				surface.SetDrawColor( 255, 255, 255, 4 )
			end
			surface.DrawRect( 0, 0, w, h )
			surface.DrawLine( 48, 0, 48, h )
			if panel.ActiveButton == self then
				surface.SetDrawColor( 255, 100, 0 )
				surface.DrawRect( 0, 0, w, 4 )
				surface.DrawRect( 0, h - 4, w, 4 )
			end
		end

		function v.Button:PerformLayout()
			if IsValid( self.m_Image ) then
				self.m_Image:SetPos( 16, ( self:GetTall() - self.m_Image:GetTall() ) * 0.5 )
				self:SetTextInset( self.m_Image:GetWide() + 16, 0 )
			end
			DLabel.PerformLayout( self )
		end

	end

	sheet:AddSheet( k, panel )

end

for _, v in ipairs( sheet.Items ) do

	v.Tab:SetFont( "HudHintTextLarge" )

	function v.Tab:Paint( w, h )
		if self:IsActive() then
			surface.SetDrawColor( 255, 100, 0 )
			surface.DrawRect( 0, 0, w, h )
		else
			surface.SetDrawColor( 0, 0, 0, 64 )
			surface.DrawRect( 0, 0, w, h )
		end
		surface.SetDrawColor( 255, 255, 255, 48 )
		surface.DrawLine( 0, 0, w, 0 )
	end

end
