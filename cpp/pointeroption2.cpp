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
	vector<Object> objects;

	for (int i = 0; i < 3; i++)
	{
		// Create object pointer
		Object obj;
		// Store some random data in an object
		obj.value = i;
		objects.push_back(obj);
	}

	// Print object values
	for (auto object: objects)
	{
		cout << object.value << '\n';
	}

	return 0;
}