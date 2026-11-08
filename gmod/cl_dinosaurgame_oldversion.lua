
--sv_dinosaurgame.lua is needed as well as this file

math.randomseed( os.time() )

local leaderboardframe
local spanel
local shouldmakeleaderboard = false

local function MakeLeaderBoard( tbl )

	leaderboardframe = vgui.Create( 'DFrame', spanel )
	leaderboardframe:SetSize( ScrW() / 2, ScrH() - 200 )
	leaderboardframe:SetTitle( 'Dinosaur Game Leaderboard' )
	leaderboardframe:Center()
	leaderboardframe:SetSizable( true )
	leaderboardframe:SetIcon( 'icon16/chart_bar.png' )
	leaderboardframe.Paint = function( self, w, h )
		surface.SetDrawColor( 83, 83, 83, 255 )
		surface.DrawRect( 0, 0, w, h )
		draw.RoundedBox( 10, 10, 24+10, w - 20, h - 24 - 20, Color( 70, 70, 70, 255 ) )
		surface.SetDrawColor( 100, 100, 100, 255 )
		surface.DrawRect( 0, 0, w, 24 )
	end
	leaderboardframe:MakePopup()
	
	local scroll = vgui.Create( 'DScrollPanel', leaderboardframe )
	scroll:Dock( FILL )
		
	local dlist = vgui.Create( 'DListLayout', scroll )
	dlist:Dock( FILL )
	dlist:DockPadding( 10, 10, 10, 10 )
	
	local infobox = vgui.Create( 'DPanel' )
	infobox:SetSize( 0, 50 )
	
	infobox.Paint = function( self, w, h )
		surface.SetTextColor( 247, 247, 247, 255 )
		surface.SetFont( 'DermaLarge' )
			
		local tw, th = surface.GetTextSize( "Name" )
		surface.SetTextPos( w/4 - (tw/2), h/2 - (th/2) )
		surface.DrawText( "Name" )
			
		local tw2, th2 = surface.GetTextSize( "Score" )
		surface.SetTextPos( w-(w/4) - (tw2/2), h/2 - (th2/2) )
		surface.DrawText( "Score" )
	end
	
	dlist:Add( infobox )
	
	table.sort( tbl )
	
	for key, val in SortedPairsByValue( tbl, true ) do
		
		local box = vgui.Create( 'DPanel' )
		box:SetSize( 0, 30 )
		
		box.Paint = function( self, w, h )
		
			draw.RoundedBox( 10, 0, 0, w, h, Color( 50, 50, 50, 255 ) )
			
			surface.SetDrawColor( 90, 90, 90, 255 )
			surface.DrawRect( ( w/2 ) - 2, 0, 4, h )
			
			surface.SetTextColor( 247, 247, 247, 255 )
			surface.SetFont( 'CloseCaption_Normal' )
			
			local tw, th = surface.GetTextSize( key:Nick() )
			surface.SetTextPos( w/4 - (tw/2), h/2 - (th/2) )
			surface.DrawText( key:Nick() )
			
			local tw2, th2 = surface.GetTextSize( math.floor( val ) )
			surface.SetTextPos( w-(w/4) - (tw2/2), h/2 - (th2/2) )
			surface.DrawText( math.floor( val ) )
			
		end
		
		box:DockMargin( 0, 0, 0, 5 )
		
		dlist:Add( box )
		
	end
	
end

concommand.Add( 'DinosaurGame', function()

-- TODO- get color mode to work and add ground bumps and mlg mode
-- Also, fix the bug where pressing ~ makes you fly forever
-- Also fix the leaderboard so it's part of the game rather than a separate window (use panelparentingtest.lua to test)
	
	local math = math
	local table = table
	-- to speed things up
	
	local scale = ScrW() * 0.052 -- this affects the size of everything
	local addscreenspeed = ScrW() * 0.043 -- it adds more distance to your game if your screen is bigger for compensation
	local screenspeed = ScrW() * 0.51 -- the speed of stuff gets faster to compensate for screen size
	
	local slowmosound = CreateSound( LocalPlayer(), 'dinogame/chariots_of_fire.wav' )
	local fastmosound = CreateSound( LocalPlayer(), 'dinogame/sonic_green_hill.wav' )
	
	local Base = vgui.Create( 'DFrame' )
	Base:SetTitle( 'Chrome ~ Dinosaur Game Replica' )
	Base:SetSize( ScrW() - 100, ScrH() - 100 )
	Base:Center()
	Base:MakePopup()
	Base:SetIcon( 'icon16/controller.png' )
	Base.Paint = function( self, w, h )
		surface.SetDrawColor( 0, 0, 0, 255 )
		surface.DrawRect( 0, 0, w, h )
	end
	Base:SetDeleteOnClose( false )
	Base.Close = function()
		slowmosound:Stop()
		fastmosound:Stop()
		if IsValid(spanel) then spanel:Remove() end
		if IsValid(leaderboardframe) then leaderboardframe:Remove() end
		Base:Remove()
	end

	local Button = vgui.Create( 'DButton', Base )
	Button:Dock( FILL )
	Button:SetText( '' )

	Base:InvalidateLayout()
	Base:InvalidateChildren()
	
	local w, h = Button:GetSize()
	local score = 0
	local hiscore = 0
	local dino -- create this variable here for use in the script below
	local SpawnInitialGroundGrain -- create this variable here for use in the script below
	local groundgrain -- create this variable here for use in the script below
	local fullscreenenabled = false
	local colorenabled = false
	local noclip = false
	local motionstate = 'normal'
	local mlgmodeenabled = false
	local timerspeed = 0.3 -- a third of a second to reach the top of the jump
	
	local RestartGame
	local DoFailure
	
	local function UsingCheats()
		if motionstate ~= 'normal' then return true end
		if noclip then return true end
		if mlgmodeenabled then return true end
		return false
	end
	
	local function GoFullScreen()
		Base:SetPos( 0, 0 )
		Base:SetSize( ScrW(), ScrH() )
		Base:DockPadding( 0, 0, 0, 0 )
		Base:InvalidateLayout()
		Base:InvalidateChildren()
		w, h = Button:GetSize()
		dino.y = h-(h/3)
		groundgrain = {}
		SpawnInitialGroundGrain( 30 )
		fullscreenenabled = true
	end
	
	local function StopFullScreen()
		Base:SetSize( ScrW() - 100, ScrH() - 100 )
		Base:Center()
		Base:DockPadding( 5, 24 + 5, 5, 5 ) -- default dock padding
		Base:InvalidateLayout()
		Base:InvalidateChildren()
		w, h = Button:GetSize()
		dino.y = h-(h/3)
		groundgrain = {}
		SpawnInitialGroundGrain( 30 )
		fullscreenenabled = false
	end
	
	local function AddDisabledCheatThingy( parent, score )
		local label = vgui.Create( 'DLabel', parent )
		label:SetFont( 'CloseCaption_Normal' )
		label:SetText( 'Cheat locked' )
		label:SetBright( true )
		label:Dock( TOP )
		local label2 = vgui.Create( 'DLabel', parent )
		label2:SetText( 'High score of '..score..' required' )
		label2:Dock( TOP )
	end
	
	local function AddCheat( parent, text, var, scoreneeded )
		
		local box
		
		if hiscore > scoreneeded then
			box = vgui.Create( 'DCheckBoxLabel', parent )
			box:SetText( text )
			box:SetValue( var )
			box:Dock( TOP )
		else
			AddDisabledCheatThingy( parent, scoreneeded )
		end
		
		return box
	
	end
	
	local function AddSettingBox( parent, txt, val )
	
		local box = vgui.Create( 'DCheckBoxLabel', parent )
		
		box:SetText( txt )
		box:SetValue( val )
		box:Dock( TOP )
		
		return box
	end
	
	local function OpenSettingsPanel()
		
		RestartGame()
		
		spanel = vgui.Create( 'DFrame' )
		spanel:SetTitle( 'Settings' )
		spanel:SetIcon( 'icon16/cog.png' )
		spanel:SetSize( ScrW() / 3, ScrH() / 1.2 )
		spanel:Center()
		spanel:SetSizable( true )
		spanel:SetDeleteOnClose( true )
		spanel:MakePopup()
		spanel.Paint = function( self, w, h )
			surface.SetDrawColor( 80, 80, 80, 255 )
			surface.DrawRect( 0, 0, w, h )
			surface.SetDrawColor( 40, 40, 40, 255 )
			surface.DrawRect( 10, 24, w - 20, h - 34 )
			surface.SetDrawColor( 100, 100, 100, 255 )
			surface.DrawRect( 0, 0, w, 24 )
		end
		
		local scroll = vgui.Create( 'DScrollPanel', spanel )
		scroll:Dock( FILL )
		
		local listlayout = vgui.Create( 'DListLayout', scroll )
		listlayout:Dock( FILL )
		listlayout:DockPadding( 20, 20, 20, 20 )
		
		local settingslbl = vgui.Create( 'DLabel' )
		settingslbl:SetText( 'Settings' )
		settingslbl:SetFont( 'Trebuchet24' )
		settingslbl:SetContentAlignment( 5 )
		settingslbl:SizeToContents()
		listlayout:Add( settingslbl )
		
		local settingsbox = vgui.Create( 'DPanel' )
		settingsbox:DockPadding( 5, 5, 5, 5 )
		settingsbox.Paint = function( self, w, h )
			surface.SetDrawColor( 30, 30, 30, 255 )
			surface.DrawRect( 0, 0, w, h )
		end
		listlayout:Add( settingsbox )
		
		local fullscreen = AddSettingBox( settingsbox, 'Fullscreen mode', fullscreenenabled )
		local colormode = AddSettingBox( settingsbox, 'Color', colorenabled )
		
		local splitrect = vgui.Create( 'DPanel' )
		splitrect:SizeToContents()
		splitrect.Paint = function( self, w, h )
			surface.SetDrawColor( 80, 80, 80, 255 )
			surface.DrawRect( 0, h/2 - 2, w, 4 )
		end
		listlayout:Add( splitrect )
		
		local cheatlbl = vgui.Create( 'DLabel' )
		cheatlbl:SetText( 'CHEATS' )
		cheatlbl:SetFont( 'DermaLarge' )
		cheatlbl:SetColor( Color( 255, 0, 0, 255 ) )
		cheatlbl:SetContentAlignment( 5 )
		cheatlbl:SizeToContents()
		listlayout:Add( cheatlbl )
		
		local cheatbox = vgui.Create( 'DPanel' )
		cheatbox:DockPadding( 5, 5, 5, 5 )
		cheatbox.Paint = settingsbox.Paint
		listlayout:Add( cheatbox )
		
		local speedbox
		if hiscore > 100 then
			speedbox = vgui.Create( 'DComboBox', cheatbox )
			speedbox:SetValue( ( motionstate == 'normal' and 'Normal motion' ) or ( motionstate == 'fast' and 'Fast motion' ) or ( motionstate == 'slow' and 'Slow motion' ) )
			speedbox:AddChoice( 'Slow motion' )
			speedbox:AddChoice( 'Normal motion' )
			speedbox:AddChoice( 'Fast motion' )
			speedbox:Dock( TOP )
		else
			AddDisabledCheatThingy( cheatbox, 100 )
		end
		
		local nocollide = AddCheat( cheatbox, 'No collisions', noclip, 200 )
		local mlgmode = AddCheat( cheatbox, 'MLG mode', mlgmodeenabled, 300 )
		
		local warninglbl = vgui.Create( 'DLabel' )
		warninglbl:SetText( "Note - If you're using cheats, your high score won't change" )
		warninglbl:SetColor( Color( 255, 0, 0, 255 ) )
		warninglbl:SetContentAlignment( 2 )
		warninglbl:SizeToContents()
		listlayout:Add( warninglbl )
		
		local splitrect2 = vgui.Create( 'DPanel' )
		splitrect2:SizeToContents()
		splitrect2.Paint = splitrect.Paint
		listlayout:Add( splitrect2 )
		
		settingsbox:InvalidateLayout( true )
		settingsbox:SizeToChildren( true, true )
		
		cheatbox:InvalidateLayout( true )
		cheatbox:SizeToChildren( true, true )
		
		local apply = vgui.Create( 'DButton' )
		apply:SetText( 'Apply changes' )
		apply.DoClick = function()
		
			if fullscreen:GetChecked() then
				GoFullScreen()
			else
				StopFullScreen()
			end
			
			if speedbox then
				if speedbox:GetValue() == 'Slow motion' then
					motionstate = 'slow'
					timerspeed = 0.6
				elseif speedbox:GetValue() == 'Normal motion' then
					motionstate = 'normal'
					timerspeed = 0.3
				elseif speedbox:GetValue() == 'Fast motion' then
					motionstate = 'fast'
					timerspeed = 0.15
				end
			end
			
			if nocollide and nocollide:GetChecked() then
				noclip = true
			else
				noclip = false
			end
			
			if colormode and colormode:GetChecked() then
				colorenabled = true
			else
				colorenabled = false
			end
			
			if mlgmode and mlgmode:GetChecked() then
				mlgmodeenabled = true
			else
				mlgmodeenabled = false
			end
		
			spanel:Remove()
		end
		apply.Paint = function( self, w, h )
			surface.SetDrawColor( 255, 255, 255, 255 )
			surface.DrawRect( 0, 0, w, h )
		end
		apply.DoRightClick = apply.DoClick
		listlayout:Add( apply )
		
	end
	
	local SettingsButton = vgui.Create( 'DImageButton', Button )
	SettingsButton:SetSize( 24, 24 )
	SettingsButton:SetPos( 5, 5 )
	SettingsButton:SetImage( 'icon16/cog.png' )
	SettingsButton.DoClick = OpenSettingsPanel
	SettingsButton.DoRightClick = OpenSettingsPanel

	local speed = 0 -- speed of movement
	local cactusspawnrate = 40 -- the smaller this is, the more cacti spawn
	local soundplayed = false
	local TimersExist = false
	local failed = false
	local downreleased = true
	
	local dinoleft = Material( 'dinogame/dinoleft.png', 'alphatest noclamp' )
	local dinoright = Material( 'dinogame/dinoright.png', 'alphatest noclamp' )
	local deaddino = Material( 'dinogame/dead.png', 'alphatest noclamp' )
	local lowleft = Material( 'dinogame/lowleft.png', 'alphatest noclamp' )
	local lowright = Material( 'dinogame/lowright.png', 'alphatest noclamp' )
	local stilldino = Material( 'dinogame/still.png', 'alphatest noclamp' )
	local dinoblink = Material( 'dinogame/blink.png', 'alphatest noclamp' )
	local cloud = Material( 'dinogame/cloud.png', 'alphatest noclamp' )
	local gameover = Material( 'dinogame/gameover.png', 'alphatest noclamp' )
	local retrysymbol = Material( 'dinogame/retry.png', 'alphatest noclamp' )
	local flapup = Material( 'dinogame/wingsup.png', 'alphatest noclamp' )
	local flapdown = Material( 'dinogame/wingsdown.png', 'alphatest noclamp' )
	local cactimats = {
		{ mat = ( Material( 'dinogame/smallcacti1.png', 'alphatest noclamp' ) ), w = (scale/2), h = scale },
		{ mat = ( Material( 'dinogame/smallcacti2.png', 'alphatest noclamp' ) ), w = scale, h = scale },
		{ mat = ( Material( 'dinogame/smallcacti3.png', 'alphatest noclamp' ) ), w = scale, h = scale, ch = scale/2 }, -- ch means collision height since the cactus texture is bigger than the actual cactus bit
		{ mat = ( Material( 'dinogame/largecacti1.png', 'alphatest noclamp' ) ), w = (scale/2), h = scale },
		{ mat = ( Material( 'dinogame/largecacti2.png', 'alphatest noclamp' ) ), w = scale, h = scale },
		{ mat = ( Material( 'dinogame/largecacti3.png', 'alphatest noclamp' ) ), w = (scale*1.5), h = (scale*1.5), ch = scale },
	}

	local function inQuad(t, b, c, d)
		if not t then return 0 end -- to prevent errors that still somehow occur if you retry really fast
		t = t / d
		return c * math.pow(t, 2) + b
	end

	local function outQuad(t, b, c, d)
		if not t then return 0 end -- to prevent errors that still somehow occur if you retry really fast
		t = t / d
		return -c * t * (t - 2) + b
	end

	groundgrain = {}  -- not global, created this variable before
	local clouds = {}
	local cacti = {}
	local pterodactyl = {}
	dino = { -- not global, created this variable before
		x = w/6,
		y = h-(h/3),
		w = scale,
		h = scale,
	}
	
	local blinkmat = stilldino -- this makes the dino blink
	
	local function DrawStuff()
	
		if TimersExist and timer.Exists( 'DinoJumpUpTimer' ) then
			dino.y =  h-(h/3) - ( outQuad( timerspeed - timer.TimeLeft( 'DinoJumpUpTimer' ), 0, timerspeed, timerspeed ) * h / (timerspeed*3) )
		end
		if TimersExist and timer.Exists( 'DinoJumpDownTimer' ) then
			dino.y = h-(h/3) - ( outQuad( timer.TimeLeft( 'DinoJumpDownTimer' ), 0, timerspeed, timerspeed ) * h / (timerspeed*3) )
		end
		
		surface.SetDrawColor( 218, 218, 218, 255 )
		
		for _, v in pairs(clouds) do
			surface.SetDrawColor( 255, 255, 255, 255 )
			surface.SetMaterial( cloud )
			surface.DrawTexturedRect( v.x, v.y, scale, scale/4 )
		end
		
		surface.SetDrawColor( 83, 83, 83, 255 )
		
		--surface.DrawLine( 0, h-(h/3), w, h-(h/3) )
		surface.DrawRect( 0, h-(h/3) - 1, w, 2 )
		
		for _, v in pairs(groundgrain) do
			--surface.DrawRect( v.x, v.y, v.x + v.w, 2 )
			surface.DrawRect( v.x, v.y, v.w, 2 )
		end
		
		surface.SetDrawColor( 255, 255, 255, 255 )
		
		for _, v in pairs(cacti) do
			surface.SetMaterial( v.mat )
			surface.DrawTexturedRect( v.x, h-(h/3) - v.h + 10, v.w, v.h )
		end
		
		for _, v in pairs(pterodactyl) do
			if math.floor(score) % 3 == 0 then
				surface.SetMaterial( flapup )
			else
				surface.SetMaterial( flapdown )
			end
			surface.DrawTexturedRect( v.x, v.y, scale, scale )
		end
		
		if failed then
			surface.SetMaterial( deaddino )
			dino.w = scale
			dino.h = scale
		else
			if speed == 0 then -- it's the start of the game
				if math.floor(SysTime()) % 5 == 0 then
					blinkmat = dinoblink
					timer.Simple( 0.5, function()
						blinkmat = stilldino
					end )
				end
				surface.SetMaterial( blinkmat )
				dino.w = scale
				dino.h = scale
			else
				if TimersExist then
					surface.SetMaterial( stilldino )
					dino.w = scale
					dino.h = scale
				else
					if math.floor(score) % 2 == 0 then
						if downreleased then
							surface.SetMaterial( dinoleft )
							dino.w = scale
							dino.h = scale
						else
							surface.SetMaterial( lowleft )
							dino.w = scale*1.4
							dino.h = scale/1.6
						end
					else
						if downreleased then
							surface.SetMaterial( dinoright )
							dino.w = scale
							dino.h = scale
						else
							surface.SetMaterial( lowright )
							dino.w = scale*1.4
							dino.h = scale/1.6
						end
					end
				end
			end
		end
		
		surface.DrawTexturedRect( dino.x, dino.y-dino.h+2, dino.w, dino.h )
		
		surface.SetDrawColor( 83, 83, 83, 255 )
		
		surface.SetFont( 'CloseCaption_Bold' )
		
		local s = string.rep( '0', 5 - #tostring(math.floor(score)) ) .. math.floor(score)
		local tw, th = surface.GetTextSize( s )
		
		surface.SetTextColor( 83, 83, 83, 255 )
		surface.SetTextPos( w - tw - 10, th - 10 )
		surface.DrawText( s )
		
		local s2 = 'HI '..string.rep( '0', 5 - #tostring(math.floor(hiscore)) ) .. math.floor(hiscore)
		local tw2, th2 = surface.GetTextSize( s2 )
		
		surface.SetTextColor( 115, 115, 115, 255 )
		surface.SetTextPos( w - tw - 20 - tw2, th - 10 )
		surface.DrawText( s2 )
		
	end

	local function CactusShouldSpawn(key)
		local oldkey = cacti[key-1]
		if speed == 0 then return false end
		if score < 30 then return false end
		if not oldkey then return true end
		if oldkey.x < w / (math.random(cactusspawnrate/2,cactusspawnrate)/10)
		and math.random( 2 ) == 2 then -- throw in a random chance, why not
		--or math.random(100)== 100 then
			return true
		end
		return false
	end
	
	function SpawnInitialGroundGrain(count)  -- not global, created this variable before
		for i = 1, count do
			table.insert( groundgrain, {
				x = math.random( 0, w ),
				y = math.random(h-(h/3),h),
				w = math.random( 2, 30 ),
			} )
		end
	end
	
	local function ShouldSpawnGrain( key )
		if math.random(2) == 2 and speed ~= 0 then
			local prevkey = groundgrain[ key-1 ]
			if not prevkey then return true end
			if prevkey.x < w/1.02 then return true end
		end
		return false
	end
	
	local function UpdateGroundGrain()
		if ShouldSpawnGrain( #groundgrain+1 ) then -- create a grain
			table.insert( groundgrain, {
				x = w,
				y = math.random(h-(h/3),h),
				w = math.random( 2, 15 ),
			} )
		end
		for k,v in pairs(groundgrain) do -- update grain position
			groundgrain[k].x = v.x - (speed*RealFrameTime())
			if groundgrain[k].x + groundgrain[k].w < 0 then -- remove off-screen grains
				--groundgrain[k] = nil
				table.remove( groundgrain, k )
			end
		end
	end
	
	local function CheckCactusCollision( key )
		if noclip then return end
		if dino.x + dino.w > key.x + 10 -- +10 to be fair
		and dino.y > h-(h/3) - (( key.ch or key.h - 15 )) -- ch = collision height, for if the cactus picture is bigger than the actual cactus, also -15 to be fair
		and dino.x < key.x + key.w - 10 -- -10 to be fair
		and !failed then
			DoFailure()
		end
	end
	
	local function UpdateCacti()
		if CactusShouldSpawn(#cacti+1) then
			local randomkey = math.random( #cactimats )
			table.insert( cacti, {
				x = w,
				mat = cactimats[randomkey].mat,
				w = cactimats[randomkey].w,
				ch = cactimats[randomkey].ch,
				h = cactimats[randomkey].h,
			} )
		end
		for k,v in pairs(cacti) do -- update cactus position
			CheckCactusCollision(cacti[k]) -- check collisions
			cacti[k].x = v.x - (speed*RealFrameTime())
			if cacti[k].x + cacti[k].w < 0 then -- remove off-screen cacti
				--cacti[k] = nil
				table.remove( cacti, k )
			end
		end
	end
	
	local function ShouldSpawnCloud( key )
		if speed == 0 then return false end
		if clouds[key-1] == nil then return true end
		if clouds[key-1].x < w / 2 then return true end
		return false
	end
	
	local function UpdateClouds()
		if ShouldSpawnCloud( #clouds+1 ) then
			table.insert( clouds, {
				x = w,
				y = math.random( 20, h/3 ),
			} )
		end
		for k,v in pairs(clouds) do
			clouds[k].x = clouds[k].x - (( speed*RealFrameTime() ) / 3 )
			if clouds[k].x + scale < 0 then
				--clouds[k] = nil
				table.remove( clouds, k )
			end
		end
	end
	
	local spawnedpterodactyl = false
	
	local function ShouldSpawnPterodactyl( key )
		if score > 450 and speed ~= 0 then
			if not pterodactyl[ key-1 ] and math.random( 2 ) == 2 then return true end
		end
		return false
	end
	
	local function CheckPterodactylCollision( tbl )
		if noclip then return end
		if dino.x + dino.w > tbl.x
		and dino.y - dino.h < tbl.y + scale
		and dino.x < tbl.x + scale
		and dino.y > tbl.y
		and !failed then
			DoFailure()
		end
	end
	
	local function UpdatePterodactyl()
		if ShouldSpawnPterodactyl( #pterodactyl+1 ) then
			if !spawnedpterodactyl then
				spawnedpterodactyl = true
				table.insert( pterodactyl, {
					x = w,
					y = math.random( 0, h-(h/3) - scale ), -- scale is the height
				} )
			end
		else
			spawnedpterodactyl = false
		end
		for k,v in pairs(pterodactyl) do
			CheckPterodactylCollision(pterodactyl[k])
			pterodactyl[k].x = pterodactyl[k].x - (( speed*RealFrameTime() ) * 1.5 )
			if pterodactyl[k].x + scale < 0 then
				--pterodactyl[k] = nil
				table.remove( pterodactyl, k )
			end
		end
	end
	
	local function DrawFailedSign()
		--surface.SetFont( 'CloseCaption_Bold' )
		--local tw, th = surface.GetTextSize( 'G A M E    O V E R' )
		--local boxw, boxh = w/15, h/10
		--surface.SetTextColor( 83, 83, 83, 255 )
		--surface.SetTextPos( w/2 - (tw / 2), h/2 - (th / 2) - (boxh/2) )
		--surface.DrawText( 'G A M E    O V E R' )
		--draw.RoundedBox( 10, w/2 - (boxw/2), h/2 + boxh/2 - (th/2), boxw, boxh, Color( 83, 83, 83, 255 ) )
		local middlegap = 64 -- the size of the box
		surface.SetDrawColor( 255, 255, 255, 255 )
		surface.SetMaterial( gameover )
		surface.DrawTexturedRect( w/2 - (381/2), h/2 - (21/2) - (middlegap/2), 381, 21 )
		surface.SetMaterial( retrysymbol )
		surface.DrawTexturedRect( w/2 - (72/2), h/2 - (64/2) + (middlegap/2), 72, 64 )
	end
	
	function DoFailure() -- not global, defined before
		speed = 0
		TimersExist = false
		failed = true -- we died
		slowmosound:Stop()
		fastmosound:Stop()
		surface.PlaySound( 'dinogame/lose.wav' )
		timer.Remove( 'DinoJumpDownTimer' )
		timer.Remove( 'DinoJumpUpTimer' )
		if !UsingCheats() then -- why bother sending it if they're cheating?
			shouldmakeleaderboard = true
			net.Start( 'dinogame_doleaderboard' )
			net.WriteFloat( hiscore )
			net.SendToServer()
		end
	end
	
	function RestartGame()
		if IsValid( leaderboardframe ) then leaderboardframe:Remove() end
		shouldmakeleaderboard = false
		speed = 0
		score = 0
		slowmosound:Stop()
		fastmosound:Stop()
		TimersExist = false
		failed = false
		downreleased = true
		soundplayed = false
		cactusspawnrate = 40
		groundgrain = {}
		clouds = {}
		pterodactyl = {}
		cacti = {}
		dino = {
			x = w/6,
			y = h-(h/3),
			w = scale,
			h = scale,
		}
		SpawnInitialGroundGrain( 30 )
	end
	
	SpawnInitialGroundGrain( 30 )
	
	local gotreleasedbefore = true

	function Button.Paint( self, w, h )
	
		surface.SetDrawColor( 247, 247, 247, 255 )
		surface.DrawRect( 0, 0, w, h )
		
		if input.IsKeyDown( KEY_SPACE ) or input.IsKeyDown( KEY_UP ) and downreleased then
			Button:DoClick()
			gotreleasedbefore = false
		else
			gotreleasedbefore = true
		end
	
		if input.IsKeyDown( KEY_DOWN ) and !failed then
			if downreleased then
				TimersExist = false
				timer.Remove( 'DinoJumpDownTimer' )
				timer.Remove( 'DinoJumpUpTimer' )
				downreleased = false
			else
				dino.y = math.Clamp( dino.y + ((( motionstate == 'slow' and 500 ) or ( motionstate == 'fast' and 1500 ) or 1000 ) * RealFrameTime()), 0, h-(h/3) )
			end
		else
			if !downreleased then
				downreleased = true
				dino.y = h-(h/3)
			end
		end
		
		if input.IsKeyDown( KEY_ESCAPE ) and fullscreenenabled then
			StopFullScreen()
		end
		
		DrawStuff()
		UpdateGroundGrain()
		UpdateCacti()
		UpdatePterodactyl()
		UpdateClouds()
		if speed ~= 0 then
			score = score + RealFrameTime() * ( ( motionstate == 'slow' and 5 ) or ( motionstate == 'fast' and 20 ) or 10 )
			if math.floor( score ) ~= 0 and math.floor( score ) % 100 == 0 then
				if !soundplayed then
					surface.PlaySound( 'dinogame/scoreup.wav' )
					soundplayed = true
					speed = math.Clamp( speed + (( motionstate == 'slow' and addscreenspeed/2 ) or ( motionstate == 'fast' and addscreenspeed*2 ) or addscreenspeed ), 0, 6000 )
					cactusspawnrate = math.Clamp( cactusspawnrate - 2, 20, 40 )
				end
				else
				soundplayed = false
			end
			if score > hiscore and !UsingCheats() then
				hiscore = score
			end
		end
		if failed then DrawFailedSign() end
	end

	function Button.DoClick()
		
		if failed then
		
			if gotreleasedbefore then
				RestartGame()
			end
			
		else
		
			if speed == 0 then
				speed = (( motionstate == 'slow' and screenspeed/2 ) or ( motionstate == 'fast' and screenspeed*2 ) or screenspeed )
				if motionstate == 'slow' then slowmosound:Play()
				elseif motionstate == 'fast' then fastmosound:Play() end
				if IsValid( spanel ) then spanel:Remove() end
			end
			
			if TimersExist then return end
			
			surface.PlaySound( 'dinogame/jump.wav' )
			
			timer.Create( 'DinoJumpUpTimer', timerspeed, 1, function()
				timer.Create( 'DinoJumpDownTimer', timerspeed, 1, function()
					dino.y = h-(h/3)
					TimersExist = false
				end )
			end )
			TimersExist = true
		
		end
		
	end
	
	Button.DoRightClick = Button.DoClick
	
end )

net.Receive( 'dinogame_doleaderboard', function() 

	local leaderboard = net.ReadTable()
	
	timer.Simple( 0.5, function()
		if shouldmakeleaderboard then MakeLeaderBoard( leaderboard ) end
	end	)
	
end )

print( 'Dinosaur game loaded (clientside)' )