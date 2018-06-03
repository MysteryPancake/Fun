local history = {}

hook.Add( "OnPlayerChat", "HistoryAdd", function( ply, txt )
	if ply == LocalPlayer() then
		table.insert( history, txt )
	end
end )

hook.Add( "OnChatTab", "HistoryBack", function( txt )
	if txt == "hack" then
		local last = history[ #history ]
		table.remove( history )
		return last or ""
	end
end )

local ChatOpen = false

hook.Add( "StartChat", "ChatOpen", function()
    ChatOpen = true
end )

hook.Add( "FinishChat", "ChatClose", function()
    ChatOpen = false
end )

local FirstPressed = false

hook.Add( "Think", "HistoryHack", function()
	if ChatOpen then
		local cache = input.IsKeyDown( KEY_UP )
		if cache and FirstPressed then
			hook.Run( "OnChatTab", "hack" )
		end
		FirstPressed = !cache
	end
end )
