local strtab = {}

local function AddFollowUp(str) -- adds a followup thing to the word table, e.g. I ate > ate is a followup word of I
    assert(type(str) == "string", "Invalid argument #1 for AddFollowUp (string expected)")
    str = str:lower():gsub('[.,?!“"]', "") -- remove full stops and question marks and all that
    local strs = {}
	for word in str:gmatch("%S+") do
		strs[#strs + 1] = word
	end
	for k, v in ipairs(strs) do
		local nextkey = strs[k + 1]
		if nextkey then
			if not strtab[v] then
				strtab[v] = {}
			end
			strtab[v][#strtab[v] + 1] = nextkey
		end
	end
end

local function RandomKey(tab) -- Gets a random key of a table
	local t = {}
	for k, v in pairs(tab) do
		t[#t + 1] = k
	end
	return t[math.random(#t)]
end

local function CapitalizeFirst(str) -- Capitalizes the first letter of a string
    assert(type(str) == "string", "Invalid argument #1 for CapitalizeFirst (string expected)")
	return (str:gsub("^%l", string.upper))
end

local function GenerateFollowupString(length) -- Makes a string out of words added from AddFollowUp
	local s = ""
	local prevword
	for i = 1, length do
		local randomword = RandomKey(strtab)
		if prevword then
			local followupword = strtab[prevword]
			if followupword and next(followupword) ~= nil then
				local randomwordfromtab = followupword[math.random(#followupword)]
				s = s .. " " .. randomwordfromtab
				prevword = randomwordfromtab
			else
				s = s .. ". " .. CapitalizeFirst(randomword)
				prevword = randomword
			end
		else
			s = s .. CapitalizeFirst(randomword)
			prevword = randomword
		end
	end
	return s .. "."
end

--[[
	EXAMPLE OF HOW THIS COULD BE USED:
	AddFollowUp( "This is an example string and it is short" )
	print( GenerateFollowupString( 20 ) )
	POSSIBLE OUTPUT:
	This is short. It is short. And it is short. This is an example string and it is an example.
]]
