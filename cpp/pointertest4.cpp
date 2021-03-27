#include <iostream>
using namespace std;

int messUp(int* x, int* y, int* z)
{
	return *x - *y * *z;
}

int main(int argc, char** argv)
{
	int bruh = 69;
	int bruh2 = 2;
	int bruh3 = 1;
	int bruh4 = messUp(&bruh, &bruh2, &bruh3);

	char test[] = {bruh4, bruh - 4, bruh + 7, bruh, bruh - 3, bruh - 37, bruh + 14, bruh, bruh + 19, bruh - 37, bruh + 15, bruh + 4, bruh + 11, bruh + 14};

	cout << test << '\n';
}