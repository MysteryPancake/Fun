#include <iostream>
#include <string>
#include <sstream>

using namespace std;

int main()
{
	string data = "hello,world,123";
	istringstream splitter(data);
	
	string greeting;
	getline(splitter, greeting, ',');
	cout << greeting << '\n'; // "hello"
	
	string place;
	getline(splitter, place, ',');
	cout << place << '\n'; // "world"
	
	string number;
	getline(splitter, number, ',');
	cout << number << '\n'; // "123"
}