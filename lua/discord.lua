local str = "22 Jump Street is the best movie ever made"
local numbers = { [0] = ":zero: ", ":one: ", ":two: ", ":three: ", ":four: ", ":five: ", ":six: ", ":seven: ", ":eight: ", ":nine: " }

for i = 1, #str do
	local letter = string.lower(string.sub(str, i, i))
	local number = select(2, tonumber, letter)
	if type(number) == "number" then
		io.write(numbers[number])
	elseif letter == " " then
		io.write(" ")
	else
		io.write(":regional_indicator_" .. letter .. ": ")
	end
end
