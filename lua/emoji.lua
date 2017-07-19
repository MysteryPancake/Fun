local emoji = { "👌", "😂" }

for i = 1, 140 do
	io.write( emoji[ i % #emoji + 1 ] )
end
