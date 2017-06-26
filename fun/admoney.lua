-- Use this to generate a huge list of ad break times

local lengthMinutes = 20

for i = 0, 60 * lengthMinutes do
	local minute = math.floor( i / 60 )
	local second = string.format( "%02.f", i % 60 )
	print( minute .. ":" .. second .. ", " )
end
