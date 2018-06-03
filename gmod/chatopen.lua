local ChatOpen = false

hook.Add( "StartChat", "ChatOpen", function()
    ChatOpen = true
end )

hook.Add( "FinishChat", "ChatClose", function()
    ChatOpen = false
end )
