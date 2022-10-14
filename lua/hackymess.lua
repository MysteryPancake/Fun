function meme(thing)
	assert(type(thing) == "string", "Invalid argument #1 for meme (string expected)")
	local chars = {}
	for i = 1, string.len(thing) do
		local c = #chars
		if chars[c] and chars[c].char == thing:sub(i, i) then
			chars[c].count = chars[c].count + 1
		else
			table.insert(chars, { char = thing:sub(i, i), count = 1 })
		end
	end
	local final = ""
	for _, data in ipairs(chars) do
		final = final .. data.count .. data.char
	end
	return final
end

io.write(meme(io.read()))
