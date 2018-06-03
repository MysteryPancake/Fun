RunConsoleCommand( "hud_deathnotice_time", "0" )

gameevent.Listen( "entity_killed" )

local deaths = {}
local fadeTime = 4

hook.Add( "entity_killed", "entity_killed_example", function( data )
	local victim = Entity( data.entindex_killed )
	local attacker = Entity( data.entindex_attacker )
	if victim:IsPlayer() and attacker:IsPlayer() then
		table.insert( deaths, { victim = victim:Nick(), attacker = attacker:Nick(), fade = SysTime() } )
	end
end )

hook.Add( "HUDPaint", "Fade", function()
	for k, v in ipairs( deaths ) do
		local fade = fadeTime + v.fade - SysTime()
		draw.SimpleText( v.attacker .. " defeated " .. v.victim, "DermaDefault", ScrW() * 0.95, k * 24, Color( 255, 255, 255, fade / fadeTime * 255 ), TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP )
		if fade < 0 then
			table.remove( deaths, k )
		end
	end
end )
