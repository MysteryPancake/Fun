#include <vector>

template <class T> class SimpleContainer2
{
private:
	std::vector<T> holder;
public:
	SimpleContainer2() {}
	void add(T value)
	{
		holder.push_back(value);
	}
	// ... custom methods and stuff
};