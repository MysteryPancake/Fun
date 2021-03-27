#include <iostream>

using namespace std;

void changeInt(int a)
{
    a = 420; // changes a copy
}

int main()
{
	int a = 5;
	cout << a << '\n'; // 5
	changeInt(a);
	cout << a << '\n'; // 5

	return 0;
}