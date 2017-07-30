local str = "22 Jump Street is the best movie ever made"

local numbers = {
	[ 0 ] = ":zero: ",
	[ 1 ] = ":one: ",
	[ 2 ] = ":two: ",
	[ 3 ] = ":three: ",
	[ 4 ] = ":four: ",
	[ 5 ] = ":five: ",
	[ 6 ] = ":six: ",
	[ 7 ] = ":seven: ",
	[ 8 ] = ":eight: ",
	[ 9 ] = ":nine: "
}

for i = 1, #str do
	local c = string.lower( string.sub( str, i, i ) )
	local n = tonumber( c )
	if n then
		io.write( numbers[ n ] )
	elseif c == " " then
		io.write( " " )
	else
		io.write( ":regional_indicator_" .. c .. ": " )
	end
end
