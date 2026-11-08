concommand.Add( "dj_url", function( ply, cmd, args, argsString )

local html = vgui.Create( "DHTML" )
html:OpenURL( argsString )
html:SetVisible( false )

end )