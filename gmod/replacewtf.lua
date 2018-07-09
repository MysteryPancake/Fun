hook.Add( "PlayerSay", "ReplaceWTF", function( ply, text )
    local tbl = string.Explode( " ", text )
    for k, v in ipairs( tbl ) do
        if string.lower( v ) == "wtf" then
            tbl[ k ] = "Wearing This Face"
        end
    end
    return string.Implode( " ", tbl )
end )
