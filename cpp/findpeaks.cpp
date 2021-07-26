#include <iostream>

// My O(n) peak finding algorithm
template <typename T> void findPeaks(T arr[], int size)
{
	T prev = arr[0];
	bool prevBigger = true;
	for (int i = 1; i < size; i++)
	{
		if (arr[i] <= prev && prevBigger)
		{
			std::cout << "Peak at " << i - 1 << ": " << prev << '\n';
		}
		prevBigger = arr[i] >= prev;
		prev = arr[i];
	}
}

int main()
{
	int nums[] = { 8, 6, 4, 9, 7, 7, 7, 3, 10, 5 };
	findPeaks(nums, 10); // Expected output: 8, 9, 7, 7, 10
	
	return 0;
}