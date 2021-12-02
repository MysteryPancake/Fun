// This simulates a queue of customers and a number of servers, like multithreaded processing
// Each customer is associated with a duration which represents how long the server takes to process them
// See queuesimulator.html and queuevisualiser.html for cool visualisations

#include <cstdio>

struct Server
{
	float endTime = 0.0f;
	float workTime = 0.0f;
};

class ServerArray
{
private:
	Server* arr = NULL;
	int numServers = 0;
public:
	ServerArray(int _numServers): numServers(_numServers)
	{
		arr = new Server[numServers];
	}

	~ServerArray()
	{
		delete[] arr;
	}

	Server* top(float start) const
	{
		Server* smallest = NULL;
		// Store previous time to prevent repeat calculations
		float lastTime;

		// Perform linear search, sped up by breaking
		for (int i = 0; i < numServers; i++)
		{
			float time = arr[i].endTime - start;
			if (time <= 0.0f)
			{
				// Break loop early when a free server is found
				return &arr[i];
			}
			else if (smallest == NULL || time < lastTime)
			{
				// Otherwise continue to find the smallest
				smallest = &arr[i];
				lastTime = time;
			}
		}
		return smallest;
	}

	void print(float finishTime) const
	{
		for (int i = 0; i < numServers; i++)
		{
			printf("Server %d idle time: %g\n", i + 1, finishTime - arr[i].workTime);
		}
	}
};

class WaitQueue
{
private:
	float* arr = NULL;
	int maxSize;
	int cursor = 0;
	int top = 0;
	int queueMax = 0;
public:
	WaitQueue(int _maxSize): maxSize(_maxSize)
	{
		arr = new float[_maxSize];
	}

	~WaitQueue()
	{
		delete[] arr;
	}

	void push(float time)
	{
		// Don't overflow the queue
		if (top >= maxSize)
		{
			printf("Error, queue is already full!");
		}
		else
		{
			arr[top++] = time;
			// Calculate the current length of the queue
			int currentQueue = top - cursor;
			if (currentQueue > queueMax)
			{
				queueMax = currentQueue;
			}
		}
	}

	void updateCursor(float time)
	{
		// Move past customers who already left the queue
		while (cursor < top && time > arr[cursor])
		{
			cursor++;
		}
	}

	int getMax() const
	{
		return queueMax;
	}
};

int main()
{
	// Request number of servers from user
	int numServers;
	printf("Enter the number of servers: ");
	scanf("%d", &numServers);

	// Ensure the number is positive
	if (numServers < 1)
	{
		printf("Error, number of servers must be at least 1!");
		return 0;
	}

	// Request filename from user
	char fileName[100];
	printf("Enter the filename: ");
	scanf("%s", fileName);
	FILE* textFile = fopen(fileName, "r");

	// Ensure the file can be opened
	if (textFile == NULL)
	{
		perror("Error, cannot open file!");
		return 1;
	}

	printf("\n========= %d SERVER SIMULATION =========\n", numServers);

	// Create server array
	ServerArray servers(numServers);

	// Create queue-like structure
	WaitQueue waitQueue(500);

	// Create statistic trackers
	int numServed = 0;
	float totalWait = 0.0f;
	float totalDuration = 0.0f;
	float totalService = 0.0f;
	float finishTime;

	// Read file contents two numbers at a time
	float start;
	float duration;

	// Trigger event: customer has arrived
	while (fscanf(textFile, "%f %f", &start, &duration) != EOF)
	{
		// Ignore last entry of file
		if (start == 0.0f && duration == 0.0f) break;

		// Get the best server for the customer
		Server* bestServer = servers.top(start);

		// Move past customers who already left the queue
		waitQueue.updateCursor(start);

		// Calculate how long they waited in queue
		float wait = bestServer->endTime - start;
		if (wait > 0.0f)
		{
			// Calculate when the customer will leave the queue
			waitQueue.push(start + wait);
		}
		else
		{
			// Negative wait means the server was idle, so clamp it to 0
			wait = 0.0f;
		}

		float serviceTime = duration + wait;
		bestServer->endTime = start + serviceTime;
		bestServer->workTime += duration;
		finishTime = bestServer->endTime;

		totalWait += wait;
		totalDuration += duration;
		totalService += serviceTime;
		numServed++;
	}
	
	// Print all statistics for this run
	printf("\nNumber of customers served: %d\n", numServed);
	printf("Last request completion time: %g\n", finishTime);
	printf("Average total service time per customer (including queue): %g\n", totalService / numServed);
	printf("Average total service time per customer (excluding queue): %g\n", totalDuration / numServed);
	printf("Average queue length: %g\n", totalWait / finishTime);
	printf("Maximum queue length: %d\n\n", waitQueue.getMax());

	// Print the idle times of all servers
	servers.print(finishTime);

	return 0;
}