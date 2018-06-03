-- TO WRITE THE BANNED LIST:
file.Write( "banned.txt", util.TableToJSON( banned ) )

-- TO READ THE BANNED LIST:
local banned = util.JSONToTable( file.Read( "banned.txt", "DATA" ) or "" ) or {}
