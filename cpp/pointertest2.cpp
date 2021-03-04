#include <iostream>

int main(int argc, char** argv)
{
	int tomjedi9 = 420;

	int* pointer = &tomjedi9;
	int** pointer2 = &pointer;
	int*** pointer3 = &pointer2;
	int**** pointer4 = &pointer3;
	int***** pointer5 = &pointer4;
	int****** pointer6 = &pointer5;
	int******* pointer7 = &pointer6;
	int******** pointer8 = &pointer7;
	int********* pointer9 = &pointer8;
	int********** pointer10 = &pointer9;
	int*********** pointer11 = &pointer10;
	int************ pointer12 = &pointer11;

	std::cout << ************pointer12 << std::endl;

	return 0;
}