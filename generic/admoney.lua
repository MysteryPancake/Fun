local lengthMinutes = 20

for i = 2, 60 * lengthMinutes do
	local minute = math.floor( i / 60 )
	local second = string.format( "%02.f", i % 60 )
	io.write( minute .. ":" .. second .. ", " )
end
