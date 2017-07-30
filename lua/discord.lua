local str = "My name is Jeff"

for i = 1, #str do
    local c = string.lower( string.sub( str, i, i ) )
	if c == " " then
		io.write( " " )
	else
   		io.write( ":regional_indicator_" .. c .. ": ")
	end
end
