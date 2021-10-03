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
	vector<Object> thing;

	for (int i = 0; i < 3; i++)
	{
		// Create object pointer
		Object obj;
		// Store some random data in an object
		obj.value = i;
		thing.push_back(obj);
	}

	// Print object values
	for (auto object: thing)
	{
		cout << object.value << '\n';
	}
}