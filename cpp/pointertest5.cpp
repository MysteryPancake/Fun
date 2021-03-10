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
	cout << arr[2] << endl;
	// Lookup via pointer
	cout << *(arr + 2) << endl;

	string name = "jeff";
	cout << name << endl; // jeff

	mutate(name);
	cout << name << endl; // bob

	mutate2(&name);
	cout << name << endl; // tom

	int bruh = 1;
	cout << bruh << endl; // bruh is 1

	int* bruh2 = &bruh; // get the pointer to bruh
	*bruh2 = 3; // change bruh via its pointer (pointer -> bruh = 3)
	cout << bruh << endl; // bruh is 3

	int** bruh3 = &bruh2; // get a pointer to the pointer to bruh
	**bruh3 = 4; // change bruh via 2 pointers (pointer -> pointer -> bruh = 4)
	cout << bruh << endl; // bruh is 4

	// Print both pointer locations
	cout << bruh2 << endl;
	cout << bruh3 << endl;

	char name2[] = "jeff";
	cout << name2 << endl; // jeff

	*(name2 + 1) = 'o';
	cout << name2 << endl; // joff

	return 0;
}