#include <iostream>
#include <typeinfo>

using namespace std;

int main()
{
	cout << typeid(4).name() << endl;
	cout << typeid(4.0).name() << endl;
	cout << typeid(4.0f).name() << endl;
}