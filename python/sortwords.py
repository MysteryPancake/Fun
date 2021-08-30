# This code reads a text file from user input, finds words and sorts them by unique count then alphabetically.
# C++ version is named "sortwords.cpp" and uses no built-in maps.

# Dict is like std::map in C++
result = dict()
# Count total number of words
totalWords = 0
for line in open(input("Enter the filename: "), encoding="utf8"):
	# Remove punctuation, convert to lowercase and split by spaces
	for word in ''.join(c for c in line.rstrip().lower() if c == ' ' or c.isalpha()).split(" "):
		# Ignore blank words
		if word != "":
			# Increment if word already exists, otherwise start from 1
			result[word] = result[word] + 1 if word in result else 1
			totalWords += 1
# Sort by count, then alphabetically
result = sorted(result.items(), key=lambda k: (-k[1], k[0]))
# Print final output
print("Total: {0}\nUnique: {1}\nFirst 15: {2}\nLast 15: {3}".format(totalWords, len(result), result[:15], result[-15:]))