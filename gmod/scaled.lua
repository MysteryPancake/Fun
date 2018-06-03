local yourScreenWidth = 1920 -- Change to your screen width
local yourScreenHeight = 1080 -- Change to your screen height

local function WidthScaled( x )
    return x / yourScreenWidth * ScrW()
end

local function HeightScaled( y )
    return y / yourScreenHeight * ScrH()
end

hook.Add( "HUDPaint", "Base", function()
    surface.SetDrawColor( 215, 215, 215, 255 )
    surface.DrawRect( WidthScaled( 0 ), HeightScaled( 725 ), WidthScaled( 310 ), HeightScaled( 180 ) )
end )
