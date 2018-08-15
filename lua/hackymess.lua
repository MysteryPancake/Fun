function meme( thing )
	local chars = {}
	for i = 1, string.len( thing ) do
		if chars[ #chars ] and chars[ #chars ].char == string.sub( thing, i, i ) then
			chars[ #chars ].count = chars[ #chars ].count + 1
		else
			table.insert( chars, { char = string.sub( thing, i, i ), count = 1 } )
		end
	end
	local final = ""
	for _, data in ipairs( chars ) do
		final = final .. data.count .. data.char
	end
	return final
end

io.write( meme( io.read() ) )