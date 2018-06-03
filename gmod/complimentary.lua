local function GetComplimentaryColor( color )
    local h, s, v = ColorToHSV( color )
    return HSVToColor( h + 180, s, v )
end
