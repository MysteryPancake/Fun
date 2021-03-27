#include <iostream>
using namespace std;

// Reference
void mutate(string& name)
{
	name = "bob";
}

// Pointer dereference
void mutate2(string* name)
{
	*name = "tom";
}

int main()
{
	int arr[4] = { 420, 69, 123, 456 };

	// Lookup via subscript
	cout << arr[2] << '\n';
	// Lookup via pointer
	cout << *(arr + 2) << '\n';

	string name = "jeff";
	cout << name << '\n'; // jeff

	mutate(name);
	cout << name << '\n'; // bob

	mutate2(&name);
	cout << name << '\n'; // tom

	int bruh = 1;
	cout << bruh << '\n'; // bruh is 1

	int* bruh2 = &bruh; // get the pointer to bruh
	*bruh2 = 3; // change bruh via its pointer (pointer -> bruh = 3)
	cout << bruh << '\n'; // bruh is 3

	int** bruh3 = &bruh2; // get a pointer to the pointer to bruh
	**bruh3 = 4; // change bruh via 2 pointers (pointer -> pointer -> bruh = 4)
	cout << bruh << '\n'; // bruh is 4

	// Print both pointer locations
	cout << bruh2 << '\n';
	cout << bruh3 << '\n';

	char name2[] = "jeff";
	cout << name2 << '\n'; // jeff

	*(name2 + 1) = 'o';
	cout << name2 << '\n'; // joff

	return 0;
}