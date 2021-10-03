#include <vector>
#include <iostream>

using namespace std;

class Object
{
public:
	int value;
};

int main()
{
	vector<Object*> objects;

	for (int i = 0; i < 3; i++)
	{
		// Create object pointer
		Object *objPtr = new Object();
		// Store some random data in an object
		objPtr->value = i;
		objects.push_back(objPtr);
	}

	// Print object values
	for (auto object: objects)
	{
		cout << object->value << '\n';
	}
}