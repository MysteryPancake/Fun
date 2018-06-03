local announcements = { "Visit our official website at www.origingaming.net!", "If you are ever banned, you can make a ban appeal at origingaming.net", "Remember that our administrator team is here to help you. Type @ followed by your message to get help.", "Follow the rules and have fun! Read the rules by pressing F1.", "You can apply for admin on our website, www.origingaming.net", "Join our community forums at www.origingaming.net", "Type @ followed by your message in chat to contact an admin.", "Report any rules breakers to an admin by typing @ followed by your message.", "Please respect your fellow players.", "Use common sense.", "Like our server? Please donate in the F1 menu.", "Report bugs or make suggestions on our forums - www.origingaming.net", "Please favourite our server if you enjoy playing on it", "Fishing and bitmining are easy ways to make risk free money.", "Please follow the server rules. Press F1 to read them.", "You can access the content pack by typing /content", "If you have found an exploit please report it to staff immediately, failure to do so could result in a permanent ban." }
local announcement = 1
local position = 500

hook.Add( "HUDPaint", "OGNTicker", function()

	surface.SetDrawColor( 0, 0, 0, 255 * 0.8 )
	surface.DrawRect( ScrW() * 0.25 - 2, 6, ScrW() * 0.5 + 4, 22 )

	surface.SetDrawColor( 255, 255, 255, 255 * 0.1 )
	surface.DrawOutlinedRect( ScrW() * 0.25 - 1, 7, ScrW() * 0.5 + 2, 20 )
				
	surface.SetDrawColor( 255, 255, 255, 255 * 0.81 )
	surface.DrawOutlinedRect( ScrW() * 0.25 - 3, 5, ScrW() * 0.5 + 6, 24 )
				
	render.SetScissorRect( ScrW() * 0.25, 5, ScrW() * 0.75, 24, true )
	draw.SimpleText( announcements[ announcement ], "DermaDefault", position, 17, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	render.SetScissorRect( 0, 0, 0, 0, false )

	position = position - 1 -- Change this to make it scroll slower or faster
	if position < 0 then
		position = ScrW()
		announcement = ( announcement + 1 ) % #announcements
	end

end )
