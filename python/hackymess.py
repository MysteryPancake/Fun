def meme(thing):
	chars = []
	for char in thing:
		if chars[-1:] and chars[-1]["char"] == char:
			chars[-1]["count"] += 1
		else:
			chars.append({ "char": char, "count": 1 })
	final = ""
	for data in chars:
		final += str(data["count"]) + data["char"]
	return final

print(meme(raw_input("Type some crap here: ")))
