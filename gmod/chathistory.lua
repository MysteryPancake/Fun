local history = {}

hook.Add( "OnPlayerChat", "HistoryAdd", function( ply, text )
	if ply == LocalPlayer() then
		table.insert( history, text )
	end
end )

hook.Add( "OnChatTab", "HistoryBack", function()
	local last = history[ #history ]
	table.remove( history )
	return last or ""
end )
