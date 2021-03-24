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
	cout << greeting << endl; // "hello"
	
	string place;
	getline(splitter, place, ',');
	cout << place << endl; // "world"
	
	string number;
	getline(splitter, number, ',');
	cout << number << endl; // "123"
}