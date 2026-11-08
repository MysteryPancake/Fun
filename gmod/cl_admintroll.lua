net.Receive( 'AdminTrolling', function()

	local requestplayer = LocalPlayer()

	if not ( requestplayer:IsAdmin() ) then //In case a non-admin somehow manages to start this function
		net.Start( 'AdminTrollHacker' )
		net.WriteEntity( requestplayer )
		net.SendToServer()
	return false end

	local CHOOSEVICTIMPANEL = {}
	local CHOOSEVICTIMACTIONPANEL = {}
	local PANEL1INIT = nil
	local PANEL1 = nil
	local PANEL2INIT = nil
	local PANEL2 = nil
	local victims = {}

//Setting up the base frame (Choose victims Panel)
function CHOOSEVICTIMPANEL:Init()
			local selecthelptext = nil
			local tbl = {}
			//self:SetSize( 1000, 600 )
			self:SetSize( ScrW() - 200, ScrH() - 100 )
			self:DockPadding( 20, 35, 20, 20 )
			self:Center()
			self:SetTitle( "SELECT YOUR VICTIMS!" )
			self:ShowCloseButton( true )
			self:SetDraggable( true )
			self:SetSizable( true )
			self:MakePopup()
		
		//Setting up the victims list
		self.userselect = vgui.Create( "DListView", self )
			self.userselect:Dock(FILL)
			self.userselect:SetSortable( true )
			self.userselect:SetMultiSelect( true )
			self.userselect:AddColumn( "Entity Name" )
			self.userselect:AddColumn( "Nickname" )
			self.userselect:AddColumn( "User ID" )
			self.userselect:AddColumn( "Steam ID" )
			self.userselect:AddColumn( "64-bit Steam ID" )
			self.userselect:AddColumn( "Team" )
			self.userselect:AddColumn( "Alive" )
			self.userselect:AddColumn( "Frozen" )
			local plyself = (tostring(v))
			table.Add( tbl, player.GetAll() ) //In case new players join the server or leave
				for _, v in pairs( tbl ) do
				if (requestplayer == v) then plyself = (tostring(v)) .. " ~ You" //Just for detail
				else
				plyself = (tostring(v))
				end
				self.userselect:AddLine( plyself, v:Nick(), v:UserID(), v:SteamID(), v:SteamID64(), (team.GetName(v:Team())), (tostring(v:Alive()):gsub("^%l", string.upper)), (tostring(v:IsFrozen()):gsub("^%l", string.upper)) )
			end
			surface.PlaySound( "garrysmod/balloon_pop_cute.wav" )
			
		//Setting up the lower panel with the buttons on it	
		self.userselectpanel = vgui.Create( "DPanel", self )	
		self.userselectpanel:DockMargin( 0, 10, 0, 0 ) //The slight margin
		self.userselectpanel:SetSize( 0, 35 ) //Sets the panel size
		self.userselectpanel:Dock(BOTTOM) //Docks it at the bottom
		function self.userselectpanel:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 40, 40, 40 ) )
		end
		
		//Setting up the refresh button
		self.refreshlistbutton = vgui.Create( "DButton", self.userselectpanel )
			self.refreshlistbutton:SetText( "Refresh list" )
			self.refreshlistbutton:SetSize( 100, 35 )
			self.refreshlistbutton:Dock(LEFT)
			self.refreshlistbutton.DoClick = function()
			self.userselect:Remove()
			table.Empty( tbl )

			self.userselect = vgui.Create( "DListView", self )
			self.userselect:Dock(FILL)
			self.userselect:SetSortable( true )
			self.userselect:SetMultiSelect( true )
			self.userselect:AddColumn( "Entity Name" )
			self.userselect:AddColumn( "Nickname" )
			self.userselect:AddColumn( "User ID" )
			self.userselect:AddColumn( "Steam ID" )
			self.userselect:AddColumn( "64-bit Steam ID" )
			self.userselect:AddColumn( "Team" )
			self.userselect:AddColumn( "Alive" )
			self.userselect:AddColumn( "Frozen" )
			local plyself = (tostring(v))
			table.Add( tbl, player.GetAll() ) //In case new players join the server or leave
			for _, v in pairs( tbl ) do
			if (requestplayer == v) then plyself = (tostring(v)) .. " ~ You" //Just for detail
				else
			plyself = (tostring(v))
				end
			self.userselect:AddLine( plyself, v:Nick(), v:UserID(), v:SteamID(), v:SteamID64(), (team.GetName(v:Team())), (tostring(v:Alive()):gsub("^%l", string.upper)), (tostring(v:IsFrozen()):gsub("^%l", string.upper)) )
			end
			surface.PlaySound( "garrysmod/content_downloaded.wav" )
			end
			
		//Setting up the continue button, which swaps frames
		self.continuebutton = vgui.Create( "DButton", self.userselectpanel )
			self.continuebutton:SetText( "Next" )
			self.continuebutton:SetSize( 70, 35 )
			self.continuebutton:Dock(RIGHT)
			self.continuebutton.DoClick = function()
			local linetbl = {}
			for _, line in pairs( self.userselect:GetSelected() ) do
			table.insert( linetbl, line:GetID() )
			end
			if (type(linetbl[#linetbl])) == "nil" then
				if ( self.selecthelptext == nil ) then
					self.selecthelptext = vgui.Create( "DLabel", self.userselectpanel )
					self.selecthelptext:SetSize( 130, 35 )
					self.selecthelptext:SetHighlight( true )
					self.selecthelptext:SetText( "Select your victims first!" )
					self.selecthelptext:Dock(RIGHT)
					surface.PlaySound( "buttons/button18.wav" )
				else
					surface.PlaySound( "buttons/button18.wav" )
				end
			end
			for _, v in pairs ( linetbl ) do
			table.insert( victims, tbl[v] )
			end
			PANEL2INIT = vgui.CreateFromTable( PANEL2 )
			surface.PlaySound( "garrysmod/ui_click.wav" )
			self:Remove()
		end
	end

PANEL1 = vgui.RegisterTable( CHOOSEVICTIMPANEL, "DFrame" )

//Setting up the base frame for this one (Choose Victims Action Panel). Note both these frames get registered as DFrames later.
function CHOOSEVICTIMACTIONPANEL:Init()
			//self:SetSize( 1000, 600 )
			self:SetSize( ScrW() - 200, ScrH() - 100 )
			self:DockPadding( 20, 35, 20, 20 )
			self:Center()
			self:SetTitle( "SELECT A TROLLING ACTION!" )
			self:ShowCloseButton( true )
			self:SetDraggable( true )
			self:SetSizable( true )
			self:MakePopup()
			
			//Setting up the option panel
			self.userselectpanel = vgui.Create( "DPanel", self )	
			self.userselectpanel:DockMargin( 0, 10, 0, 0 ) //The slight margin
			self.userselectpanel:SetSize( 0, 35 ) //Sets the panel size
			self.userselectpanel:Dock(BOTTOM) //Docks it at the bottom
			function self.userselectpanel:Paint( w, h )
			draw.RoundedBox( 8, 0, 0, w, h, Color( 40, 40, 40 ) )
			end
			
			//Setting up the 'close when action is done' checkbox & text
			self.noclosewhenaction = vgui.Create( "DCheckBoxLabel", self.userselectpanel )
			self.noclosewhenaction:DockMargin( 10, 10, 20, 10 )
			self.noclosewhenaction:SetSize( 240, 0 )
			self.noclosewhenaction:SetText( "Close this window once an action is chosen?" )
			self.noclosewhenaction:Dock(RIGHT)
			self.noclosewhenaction:SetValue( 1 )
			
			//Setting up the 'back' button
			self.backbutton = vgui.Create( "DButton", self.userselectpanel )
			self.backbutton:SetText( "Previous" )
			self.backbutton:SetSize( 80, 35 )
			self.backbutton:Dock(LEFT)
			self.backbutton.DoClick = function()
			table.Empty( victims )
			PANEL1INIT = vgui.CreateFromTable( PANEL1 )
			surface.PlaySound( "garrysmod/ui_return.wav" )
			self:Remove()
			end
			
			//Setting up the scrolling list
			self.Scroll = vgui.Create( "DScrollPanel", self )
			self.Scroll:Dock(FILL)
			self.Scroll:DockPadding( 5, 5, 5, 5 )
			function self.Scroll:Paint( w, h )
				draw.RoundedBox( 8, 0, 0, w, h, Color( 80, 80, 80 ) ) //Just to make it look a little cooler
			end
				
			//The actions are all on a DIconLayout
			self.trollist = vgui.Create( "DIconLayout", self.Scroll )
			self.trollist:Dock(FILL)
			self.trollist:DockMargin( 5, 5, 5, -5 )
			//trollist:SetSize( 945, 1000 )
			self.trollist:SetSpaceY( 5 )
			self.trollist:SetSpaceX( 5 )

local function ButtonCreate( buttonsize, buttontext, buttonnumcode, extraargs, extranetargs )
	local buttonname = self.trollist:Add( "DButton" )
	buttonname:SetSize( buttonsize, 70 )
	buttonname:SetText( buttontext )
	buttonname:SetTextColor( Color( 0, 0, 0, 255 ))
	if not ( extraargs == false ) then
	extraargs( buttonname )
	end
	buttonname.DoClick = function()
	net.Start( 'AdminTrollVictim' )
	net.WriteEntity( requestplayer )
	net.WriteTable( victims )
	net.WriteFloat(buttonnumcode)
	if not ( extranetargs == false ) then
	extranetargs()
	end
	net.SendToServer()
	surface.PlaySound( "garrysmod/balloon_pop_cute.wav" )
	if self.noclosewhenaction:GetChecked() then
	self:Remove()
		end
	end
end

			//Setting up any parts of any panels that need values to be given/taken
			local trollsaytext = nil
			local teamchat = nil
			local trollconcmdtext = nil
			local trollfreezeorunfreeze = nil
			local websitemanual = nil
			local websiteinteract = nil
			local soundmanual = nil
			local trollhealthnum = nil
			local trollkickmessage = nil
			local trollbantime = nil
			local trollbankicktoo = nil

			//The killing action
			local trollkill = ButtonCreate(100, "Kill the victims!", 1, false, false)
			
			//The saying action
			local trollsay = ButtonCreate(200, "Make the victims say something!", 2, function(trollsay)
			trollsaytext = self.trollist:Add( "DTextEntry" )
			trollsaytext:SetParent(trollsay)
			trollsaytext:SetPos(0, 50)
			trollsaytext:SetSize(200, 20)
			trollsaytext:SetText( "INSERT TEXT HERE" )
			teamchat = self.trollist:Add( "DCheckBoxLabel" )
			teamchat:SetParent(trollsay)
			teamchat:SetPos(110, 5)
			teamchat:SetSize(100,20)
			teamchat:SetDark(true)
			teamchat:SetText( "Team chat?" )
			teamchat:SetTextColor( Color( 0, 0, 0, 255 ))
			teamchat:SetValue(0)
			
			end, function()
			net.WriteString(trollsaytext:GetText())
			net.WriteBool(teamchat:GetChecked())
			end)
			
			//The console command action
			local trollconcommand = ButtonCreate(250, "Run a console command on the victims!", 3, function(trollconcommand)
			trollconcmdtext = self.trollist:Add( "DTextEntry" )
			trollconcmdtext:SetParent(trollconcommand)
			trollconcmdtext:SetPos(0, 50)
			trollconcmdtext:SetSize(250, 20)
			trollconcmdtext:SetText( "INSERT COMMAND HERE" )
			end, function()
			net.WriteString(trollconcmdtext:GetText())
			end)
			
			//The stripping weapons action
			local trollnoweps = ButtonCreate(250, "Strip the victims' weapons and ammo!", 4, false, false)
			
			//The item cleanup action
			local trollcleanup = ButtonCreate(250, "Remove all the victims' spawned props!", 5, false, false)
			
			//The player freeze action
			local trollfreeze = ButtonCreate(200, "Stop the victims from moving!", 6, function(trollfreeze)
			trollfreezeorunfreeze = self.trollist:Add( "DCheckBoxLabel" )
			trollfreezeorunfreeze:SetParent(trollfreeze)
			trollfreezeorunfreeze:SetPos(120, 5)
			trollfreezeorunfreeze:SetSize(100,20)
			trollfreezeorunfreeze:SetText( "Unfreeze?" )
			trollfreezeorunfreeze:SetTextColor( Color( 0, 0, 0, 255 ))
			trollfreezeorunfreeze:SetValue(0)
			end, function()
			net.WriteBool(!trollfreezeorunfreeze:GetChecked())
			end)
		
			//The fullscreen website trolling action
			local trollHTML = ButtonCreate(300, "Give the victims an unclosable fullscreen website!", 7, function(trollHTML)
			websitemanual = self.trollist:Add( "DTextEntry" )
			websitemanual:SetParent(trollHTML)
			websitemanual:SetPos(0, 50)
			websitemanual:SetSize(300, 20)
			websitemanual:SetText( "INSERT WEBSITE HERE" )
			websiteinteract = self.trollist:Add( "DCheckBoxLabel" )
			websiteinteract:SetParent(trollHTML)
			websiteinteract:SetPos(210, 5)
			websiteinteract:SetSize(100,20)
			websiteinteract:SetText( "Interactive?" )
			websiteinteract:SetTextColor( Color( 0, 0, 0, 255 ))
			websiteinteract:SetValue(0)
			end, function()
			net.WriteFloat(1)
			net.WriteString(websitemanual:GetText())
			net.WriteBool(websiteinteract:GetChecked())
			end)
			
			//The sound-playing action
			local trollsound = ButtonCreate(300, "Send the victims any sound!", 8, function(trollsound)
			soundmanual = self.trollist:Add( "DTextEntry" )
			soundmanual:SetParent(trollsound)
			soundmanual:SetPos(0, 50)
			soundmanual:SetSize(300, 20)
			soundmanual:SetText( "INSERT SOUND PATH HERE" )
			end, function()
			net.WriteFloat(2)
			net.WriteString(soundmanual:GetText())
			end)
			
			//The player health changing action
			local trollhealth = ButtonCreate(200, "Change the victims' health!", 9, function(trollhealth)
			trollhealthnum = self.trollist:Add( "DNumberWang" )
			trollhealthnum:SetParent(trollhealth)
			trollhealthnum:SetPos(0, 50)
			trollhealthnum:SetSize(200, 20)
			trollhealthnum:SetMin(0)
			trollhealthnum:SetMax(999999999)
			end, function()
			net.WriteFloat(trollhealthnum:GetValue())
			end)
			
			//The godmode actions
			local trollgodon = ButtonCreate(200, "Disable godmode on the victims!", 10, false, false)
			local trollgodoff = ButtonCreate(200, "Enable godmode on the victims!", 11, false, false)
			
			//The kicking action
			local trollkick = ButtonCreate(250, "Kick the victims from the server!", 12, function(trollkick)
			trollkickmessage = self.trollist:Add( "DTextEntry" )
			trollkickmessage:SetParent(trollkick)
			trollkickmessage:SetPos(0, 50)
			trollkickmessage:SetSize(250, 20)
			trollkickmessage:SetText( "INSERT REASON HERE (OPTIONAL)" )
			end, function()
			net.WriteString(trollkickmessage:GetText())
			end)
			
			//The banning action
			local trollban = ButtonCreate(200, "Ban the victims from the server!", 13, function(trollban)
			trollbantime = self.trollist:Add( "DNumberWang" )
			trollbantime:SetParent(trollban)
			trollbantime:SetPos(10, 50)
			trollbantime:SetSize(40, 20)
			trollbantime:SetMin(0)
			
			local trollbantimetext = self.trollist:Add( "DLabel" )
			trollbantimetext:SetParent(trollban)
			trollbantimetext:SetText( "Ban time (0 is permanent)" )
			trollbantimetext:SetTextColor( Color( 0, 0, 0, 255 ))
			trollbantimetext:SetPos(60, 50)
			trollbantimetext:SetSize(150,20)
			
			trollbankicktoo = self.trollist:Add( "DCheckBoxLabel" )
			trollbankicktoo:SetParent(trollban)
			trollbankicktoo:SetPos(120, 5)
			trollbankicktoo:SetSize(100,20)
			trollbankicktoo:SetText( "Kick too?" )
			trollbankicktoo:SetTextColor( Color( 0, 0, 0, 255 ))
			trollbankicktoo:SetValue(1)
			end, function()
			net.WriteFloat(trollbantime:GetValue())
			net.WriteBool(trollbankicktoo:GetChecked())
			end)
end

PANEL2 = vgui.RegisterTable( CHOOSEVICTIMACTIONPANEL, "DFrame" )
	
PANEL1INIT = vgui.CreateFromTable( PANEL1 ) //Necessary to open the first panel

end )

net.Receive( 'ClientsideAdminTrolls', function()

local possiblehacker = (net.ReadEntity( possiblehacker ))
local optionreceive = (net.ReadFloat( optionsend ))

	if not ( type( possiblehacker ) == "Player" ) or not ( possiblehacker:IsPlayer() ) or not ( possiblehacker:IsAdmin()) then end //If this recieves a blank field or a non-player, end it
	
	if ( optionreceive == 1 ) then
	local websitetroll = vgui.Create( "DHTML" )
	websitetroll:SetSize( ScrW(), ScrH() )
	websitetroll:OpenURL(net.ReadString())
	if (net.ReadBool()) then
	websitetroll:MakePopup()
	end

	elseif ( optionreceive == 2 ) then
	surface.PlaySound( net.ReadString() )
	end
end )