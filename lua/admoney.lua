local lengthMinutes = 20

for i = 2, 60 * lengthMinutes do
	io.write(tostring(math.floor(i / 60)) .. ":" .. tostring(string.format("%02.f", i % 60)) .. ", ")
end
