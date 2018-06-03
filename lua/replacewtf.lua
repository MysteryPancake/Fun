hook.Add( "PlayerSay", "ReplaceWTF", function( ply, txt )
    local tbl = string.Explode( " ", txt )
    for k, v in ipairs( tbl ) do
        if string.lower( v ) == "wtf" then
            tbl[ k ] = "Wearing This Face"
        end
    end
    return string.Implode( " ", tbl )
end )
