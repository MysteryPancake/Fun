-- CLIENTSIDE:
net.Start( "blah" )
net.WriteInt( score, 32 )
net.SendToServer()

-- SERVERSIDE:
util.AddNetworkString( "blah" )

local scores = {}

net.Receive( "blah", function( ply )
    local score = net.ReadInt( 32 )
    scores[ ply ] = score
end )
