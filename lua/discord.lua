local str = "My name is Jeff"

for i = 1, #str do
	local c = string.lower( string.sub( str, i, i ) )
	io.write( c == " " and " " or ":regional_indicator_" .. c .. ": " )
end
