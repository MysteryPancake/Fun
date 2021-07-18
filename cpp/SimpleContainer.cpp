template <class T> class SimpleContainer
{
private:
	T* holder;
public:
	SimpleContainer(int size)
	{
		holder = new T[size];
	}
	void set(int index, T value)
	{
		holder[index] = value;
	}
	~SimpleContainer()
	{
		delete[] holder;
	}
	// ... custom methods and stuff
};