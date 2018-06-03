hook.Add( "OnPlayerChat", "OpenCFG", function( ply, text )
	if ply == LocalPlayer() and text == "!pubg" then
		local igcfg = vgui.Create( "DFrame" )
		igcfg:SetTitle( "" )
		igcfg:SetSize( 500, 400 )
		igcfg:Center()
		igcfg:MakePopup()
		return true
	end
end )
