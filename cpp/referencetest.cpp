#include <iostream>

using namespace std;

void changeInt(int& a)
{
    a = 420; // changes a
}

int main()
{
	int a = 5;
	cout << a << '\n'; // 5
	changeInt(a);
	cout << a << '\n'; // 420

	return 0;
}