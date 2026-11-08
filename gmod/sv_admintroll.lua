AddCSLuaFile("autorun/client/cl_admintroll.lua") 

//Welcome to the actual action part that this code performs (short)

util.AddNetworkString( 'AdminTrolling' )
util.AddNetworkString( 'AdminTrollVictim' )
util.AddNetworkString( 'AdminTrollHacker' )
util.AddNetworkString( 'ClientsideAdminTrolls' )

concommand.Add( 'admin_troll', function( ply )
		if ( ply:IsAdmin()) then
			net.Start( 'AdminTrolling' )
			net.Send( ply )
		else
			ply:SendLua( [[notification.AddLegacy( "You are not an admin!", NOTIFY_ERROR, 4 )]] )
			ply:SendLua( [[surface.PlaySound( "buttons/button10.wav" )]] )
	end
end, nil, "Opens the trolling menu, which admins can use for trolling their clients.", FCVAR_CLIENTCMD_CAN_EXECUTE )

hook.Add( 'PlayerSay', 'StartAdminTrolling', function( ply, text )
	local textedit = string.lower( text )
		if ( string.sub( textedit, 1, 11 ) == '!admintroll' ) then
			if ( ply:IsAdmin()) then
			net.Start( 'AdminTrolling' )
			net.Send( ply )
			return ""
		else
			ply:SendLua( [[notification.AddLegacy( "You are not an admin!", NOTIFY_ERROR, 4 )]] )
			ply:SendLua( [[surface.PlaySound( "buttons/button10.wav" )]] )
			return ""
		end
	end
end )

net.Receive( 'AdminTrollHacker', function() //This makes anyone trying to hack this addon say that they're trying to hack it.
local hacker = (net.ReadEntity())
hacker:Say( "I tried to hack the Admin Trolling addon!", false )
end )

net.Receive( 'AdminTrollVictim', function()
local possiblehacker = (net.ReadEntity( requestplayer ))
local victimedit = (net.ReadTable( victims ))
local option = (net.ReadFloat())

	if ( possiblehacker == nil ) or not ( possiblehacker:IsPlayer() ) then end //If this recieves a blank field or a non player, end it
	if not ( possiblehacker:IsAdmin()) then //If it's not an admin, say it.
	possiblehacker:Say( "I tried to hack the Admin Trolling addon!", false )
	return end

	if ( option == 1 ) then
	for _, ply in pairs ( victimedit ) do
	if not ply:IsPlayer() then end
	ply:Kill()
	end

	elseif ( option == 2 ) then
	local texttosay = net.ReadString()
	local teamchatonly = net.ReadBool()
	for _, ply in pairs ( victimedit ) do
	if not ply:IsPlayer() then end
	ply:Say( texttosay, teamchatonly )
	end
	
	elseif ( option == 3 ) then
	local playercommand = net.ReadString()
	for _, ply in pairs ( victimedit ) do
	if not ply:IsPlayer() then end
	ply:ConCommand( playercommand )
	end
	
	elseif ( option == 4 ) then
	for _, ply in pairs ( victimedit ) do
	if not ply:IsPlayer() then end
	ply:RemoveAllItems()
	end
	
	elseif ( option == 5 ) then
	for _, ply in pairs ( victimedit ) do
	if not ply:IsPlayer() then end
	cleanup.CC_Cleanup( ply, nil, {} )
	end
	
	elseif ( option == 6 ) then
	local playerfreezebool = net.ReadBool()
	for _, ply in pairs ( victimedit ) do
	if not ply:IsPlayer() then end
	ply:Freeze( playerfreezebool )
	end
	
	elseif ( option == 7 ) then
	local optionsend = net.ReadFloat()
	local website = net.ReadString()
	local websiteinteract = net.ReadBool()
	for _, ply in pairs ( victimedit ) do
	if not ply:IsPlayer() then end
	net.Start( 'ClientsideAdminTrolls' )
	net.WriteEntity( possiblehacker )
	net.WriteFloat( optionsend )
	net.WriteString( website )
	net.WriteBool( websiteinteract )
	net.Send( ply )
	end
	
	elseif ( option == 8 ) then
	local optionsend = net.ReadFloat()
	local soundstring = net.ReadString()
	for _, ply in pairs ( victimedit ) do
	if not ply:IsPlayer() then end
	net.Start( 'ClientsideAdminTrolls' )
	net.WriteEntity( possiblehacker )
	net.WriteFloat( optionsend )
	net.WriteString( soundstring )
	net.Send( ply )
	end
	
	elseif ( option == 9 ) then
	local newhealthnum = net.ReadFloat()
	for _, ply in pairs ( victimedit ) do
	if not ply:IsPlayer() then end
	if newhealthnum > 100 then
	ply:SetMaxHealth( newhealthnum )
	end
    ply:SetHealth( newhealthnum )
	end
	
	elseif ( option == 10 ) then
	for _, ply in pairs ( victimedit ) do
	if not ply:IsPlayer() then end
	ply:GodDisable()
	end
	
	elseif ( option == 11 ) then
	for _, ply in pairs ( victimedit ) do
	if not ply:IsPlayer() then end
	ply:GodEnable()
	end
	
	elseif ( option == 12 ) then
	local kickreason = net.ReadString()
	for _, ply in pairs ( victimedit ) do
	if not ply:IsPlayer() then end
	if kickreason == "INSERT REASON HERE (OPTIONAL)" then
	ply:Kick()
	else
	ply:Kick( kickreason )
	end
	end
	
	elseif ( option == 13 ) then
	local bantime = net.ReadFloat()
	local kickaswell = net.ReadBool()
	for _, ply in pairs ( victimedit ) do
	if not ply:IsPlayer() then end
	ply:Ban( bantime, kickaswell )
	end
	end
end )