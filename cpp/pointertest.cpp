#include <iostream>

void pointerFunc(int* pointer)
{
	std::cout << &pointer << std::endl;
}

int main(int argc, char** argv)
{
	int directRef = 1;

	int* pointer = &directRef;

	pointerFunc(pointer);
	pointerFunc(pointer);
	pointerFunc(pointer);
	pointerFunc(pointer);
	pointerFunc(pointer);
	pointerFunc(pointer);
	pointerFunc(pointer);
	pointerFunc(pointer);

	return 0;
}