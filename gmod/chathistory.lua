local history = {}

hook.Add( "OnPlayerChat", "HistoryAdd", function( ply, txt )
	if ply == LocalPlayer() then
		table.insert( history, txt )
	end
end )

hook.Add( "OnChatTab", "HistoryBack", function()
	local last = history[ #history ]
	table.remove( history )
	return last or ""
end )
