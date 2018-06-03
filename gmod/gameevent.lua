gameevent.Listen( "entity_killed" )

hook.Add( "entity_killed", "entity_killed_example", function( data )
	local victim = data.entindex_killed
	local attacker = data.entindex_attacker
	local inflictor = data.entindex_inflictor
	local damagebits = data.damagebits
	local deathpane = vgui.Create( "DFrame" )
	deathpane:SetTitle( "Rest in Peace" )
	deathpane:SetSize( ScrW() * 0.5, ScrH() * 0.5 )
	deathpane:Center()
	deathpane:MakePopup()
	deathpane.Paint = function( self, w, h )
		surface.SetDrawColor( 0, 0, 0, 250 )
		surface.DrawRect( 0, 0, w, h )
		draw.SimpleText( Entity( victim ):Nick() .. " just died!", "DermaDefault", 25, 25, Color( 255, 255, 255 ) )
	end
end )
