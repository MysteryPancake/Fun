// This code reads a text file from user input, finds words and sorts them by unique count then alphabetically.
// This crashes on large files due to stack overflow.
// Python version is named "sortwords.py" and uses built-in maps.

#include <cstdlib>
#include <cstring>
#include <cstdio>
#include <cctype>

// Represents a key-value pair, like std::pair
struct WordCountPair
{
	char* word = NULL;
	int count = 0;

	// Pointers to tree branches
	WordCountPair* left = NULL;
	WordCountPair* right = NULL;

	WordCountPair() = default;
	WordCountPair(char* _word)
	{
		// Since strlen reads up to the NULL terminator, no memory is wasted here
		word = new char[strlen(_word) + 1];
		strcpy(word, _word);
		count = 1;
	}

	~WordCountPair()
	{
		delete[] word;
		delete left;
		delete right;
	}
};

// Represents a binary search tree, like std::map
class WordTree
{
private:
	WordCountPair* root = NULL;
	int unique = 0;
	int total = 0;

	WordCountPair* checkUnique(WordCountPair* branch, char* word)
	{
		// Reached end of tree, create a new leaf
		if (branch == NULL)
		{
			unique++;
			return new WordCountPair(word);
		}

		// Compare words to sort alphabetically
		int compare = strcmp(word, branch->word);
		if (compare > 0)
		{
			// Word comes later in the alphabet
			branch->right = checkUnique(branch->right, word);
		}
		else if (compare < 0)
		{
			// Word comes earlier in the alphabet
			branch->left = checkUnique(branch->left, word);
		}
		else
		{
			// Word is a duplicate
			branch->count++;
		}

		return branch;
	}

	void quickSort(WordCountPair**& arr, int lo, int hi)
	{
		// Based on https://www.geeksforgeeks.org/cpp-program-for-quicksort
		if (lo < hi)
		{
			// Partition into smaller arrays
			int i = lo - 1;
			for (int j = lo; j <= hi - 1; j++)
			{
				// Sort by count, ensuring alphabetical order is maintained
				if (arr[j]->count > arr[hi]->count || (arr[j]->count == arr[hi]->count && strcmp(arr[hi]->word, arr[j]->word) > 0))
				{
					// Swap pointers
					WordCountPair* temp = arr[++i];
					arr[i] = arr[j];
					arr[j] = temp;
				}
			}

			// Swap pointers again
			WordCountPair* temp = arr[++i];
			arr[i] = arr[hi];
			arr[hi] = temp;

			// Sort subsections
			quickSort(arr, lo, i - 1);
			quickSort(arr, i + 1, hi);
		}
	}

	void flatten(WordCountPair*& branch, WordCountPair**& arr, int& index)
	{
		if (branch != NULL)
		{
			flatten(branch->left, arr, index);
			// Store branches as pointers in the array
			arr[index++] = branch;
			flatten(branch->right, arr, index);
		}
	}
public:
	WordTree() = default;
	~WordTree()
	{
		delete root;
	}

	void push(char* word)
	{
		if (root == NULL)
		{
			// Ensure the tree has a root
			root = new WordCountPair(word);
			unique++;
		}
		else
		{
			// Insert leaves
			checkUnique(root, word);
		}
		total++;
	}

	void print()
	{
		// Create array of pointers to words
		WordCountPair** sorted = new WordCountPair*[unique];
		int index = 0;
		// Flatten tree for sorting
		flatten(root, sorted, index);

		// Sort tree by count
		quickSort(sorted, 0, unique - 1);

		// Print first 15 words
		printf("\n%30s\n\n=============================================\n| %-20s| %-20s|\n=============================================\n", "FIRST 15 WORDS", "COUNT", "WORD");
		for (int i = 0; i < 15; i++)
		{
			printf("| %-20d| %-20s|\n", sorted[i]->count, sorted[i]->word);
		}

		// Print last 15 words
		printf("=============================================\n\n%29s\n\n=============================================\n| %-20s| %-20s|\n=============================================\n", "LAST 15 WORDS", "COUNT", "WORD");
		for (int i = unique - 15; i < unique; i++)
		{
			printf("| %-20d| %-20s|\n", sorted[i]->count, sorted[i]->word);
		}
		printf("=============================================\n\nTOTAL WORDS: %d\nUNIQUE WORDS: %d\n", total, unique);

		delete[] sorted;
	}
};

int main()
{
	// Request filename and read contents using ifstream
	printf("Enter the filename: ");
	// Assume filenames never exceed 100 characters
	char fileName[100];
	scanf("%s", fileName);

	// Read contents of file
	FILE* textFile;
	textFile = fopen(fileName, "r");
	// Error checking
	if (textFile == NULL)
	{
		perror("Error, cannot open file");
		return 1;
	}

	// Create word tree to store unique words alongside their counts
	WordTree tree;

	// Assume individual words never exceed 200 characters
	char tempWord[200];
	int offset = 0;
	int c;
	// Read characters until end of file
	while ((c = fgetc(textFile)) != EOF)
	{
		if (isspace(c) && offset > 0)
		{
			// Set NULL terminator
			tempWord[offset] = '\0';
			// Check tree for existing word, allocating memory only if unique
			tree.push(tempWord);
			// Reset and start again
			offset = 0;
		}
		else if (isalpha(c) && offset < 200)
		{
			// Insert letters into temporary array
			tempWord[offset++] = tolower(c);
		}
	}

	// Insert final word
	if (offset > 0)
	{
		tempWord[offset] = '\0';
		tree.push(tempWord);
	}
	
	// Print contents of tree
	tree.print();

	// Close file
	fclose(textFile);

	return 0;
}