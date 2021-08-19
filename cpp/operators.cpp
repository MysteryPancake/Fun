#include <iostream>

#define lower(a) (a >= 'A' && a <= 'Z' ? (char)(a + 32) : a)
#define alpha(a) ((a >= 'A' && a <= 'Z') || (a >= 'a' && a <= 'z'))

int main()
{
	std::cout << lower('H') << lower('i') << lower('B') << lower('R') << lower('U') << lower('H');
	std::cout << alpha('H') << alpha('a') << alpha('?');

	return 0;
}