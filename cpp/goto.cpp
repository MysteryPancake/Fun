#include <iostream>

using namespace std;

int main()
{
	while (true)
	{
		while (true)
		{
			// Break out of both loops
			goto hell;
		}
	}
	hell:
	cout << "Exited loop\n";

	// Can be written using a flag

	bool leaveLoop = false;
	while (true)
	{
		if (leaveLoop) break;
		while (true)
		{
			// Break out of both loops
			leaveLoop = true;
			break;
		}
	}
	cout << "Exited loop\n";

	return 0;
}