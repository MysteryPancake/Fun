// This code finds the shortest and second shortest paths in a directed or undirected graph
// It represents the graph as an adjacency list, and uses the A* algorithm to find the shortest path
// It works with any number of parallel edges since it uses an adjacency list instead of an adjacency matrix
// Vertices are labelled by integer IDs, which can be any integer as long as it's unique to each vertex
// IDs are converted to indexes using a hashmap, and hashmap collisions are resolved using a linked list

#define UNDIRECTED // Comment this line if the graph is directed

#include <cstdio>
#include <cmath>

struct Vertex; // Defined later

struct Edge
{
	Vertex* from = NULL; // Connects from a vertex
	Vertex* to = NULL; // To another vertex
	double weight; // With a weight value

	Edge* next = NULL; // Next element in linked list of neighbouring edges

	Edge(Vertex* _from, Vertex* _to, double _weight):
		from(_from), to(_to), weight(_weight)
	{}

	~Edge()
	{
		delete next;
	}
};

struct Vertex
{
	int id; // Vertex ID can be anything, no ordering required!
	int index = 0; // ID resolves to an index never exceeding nVertices
	double x, y;
	
	Edge* neighbour = NULL; // Linked list of neighbouring edges
	Edge* top = NULL; // Top entry of linked list

	Edge* prev = NULL; // Previously traversed edge
	Vertex* next = NULL; // Linked list to resolve hashmap collisions

	Vertex(int _id, int _index, double _x, double _y):
		id(_id), index(_index), x(_x), y(_y)
	{}

	~Vertex()
	{
		delete neighbour;
		delete next;
	}

	double distanceTo(Vertex* other)
	{
		// Calculate euclidean distance between vertices
		double xDiff = x - other->x;
		double yDiff = y - other->y;
		return sqrt(xDiff * xDiff + yDiff * yDiff);
	}

	void connectTo(Vertex* to, double weight)
	{
		// Create linked list if it doesn't exist, otherwise insert new entry at the end
		top = (neighbour == NULL ? neighbour : top->next) = new Edge(this, to, weight);
	}
};

class HashMap
{
private:
	Vertex** vertices;
	int nVertices;
	int top = 0;

	int getHash(int id)
	{
		return id % nVertices; // Assumes IDs are typically ordered
	}
public:
	HashMap(int _nVertices):
		nVertices(_nVertices)
	{
		vertices = new Vertex*[nVertices](); // Null initialize pointer array
	}
	~HashMap()
	{
		delete[] vertices;
	}

	void add(int id, double x, double y)
	{
		// Prevent array overflow
		if (top == nVertices)
		{
			printf("Error, too many vertices!");
			return;
		}

		// Check if vertex exists
		int hash = getHash(id);
		Vertex* match = vertices[hash];
		if (match == NULL)
		{
			// Create new vertex
			vertices[hash] = new Vertex(id, top++, x, y);
		}
		else
		{
			// Find tail and set to new vertex
			while (match->next != NULL)
			{
				match = match->next;
			}
			match->next = new Vertex(id, top++, x, y);
		}
	}

	Vertex* get(int id)
	{
		// Retrieve the vertex through hashing
		Vertex* match = vertices[getHash(id)];

		// No match was found
		if (match == NULL) return NULL;

		// Instantly return matching vertex, O(1) lookup
		if (match->id == id) return match;

		// Resolve hash collision with linear search, O(n) lookup
		while (match->next != NULL)
		{
			match = match->next;
			if (match->id == id) return match;
		}

		// No match was found
		return NULL;
	}
};

class Heap
{
private:
	Vertex** heap; // Store the contents of the minimum heap
	double* estimate; // Store all current estimated distances
	Vertex* goal; // Store the goal to calculate the heuristic
	bool* added; // Store added vertices by index for O(1) lookup

	int maxSize;
	int top = -1;

	void siftUp(int i)
	{
		// Calculate the parent element
		int parent = (i - 1) / 2;

		// Ensure the root hasn't been reached and check whether swapping is required
		if (i <= 0 || estimate[heap[parent]->index] >= estimate[heap[i]->index]) return;

		// Swap the pointers
		Vertex* temp = heap[i];
		heap[i] = heap[parent];
		heap[parent] = temp;

		// Recursively call on parent
		siftUp(parent);
	}

	void siftDown(int i)
	{
		// Calculate the left and right elements
		int left = 2 * i + 1;
		int right = 2 * i + 2;
		int smallest = i;

		// Find the smallest estimate of both elements
		if (left <= top && estimate[heap[left]->index] < estimate[heap[i]->index]) smallest = left;
		if (right <= top && estimate[heap[right]->index] < estimate[heap[smallest]->index]) smallest = right;

		// Check whether we reached the smallest value
		if (smallest == i) return;

		// Swap pointers
		Vertex* temp = heap[i];
		heap[i] = heap[smallest];
		heap[smallest] = temp;

		// Recursively call on smallest
		siftDown(smallest);
	}

	double heuristic(Vertex* target)
	{
		// Heuristic is the euclidean distance to the goal
		return target->distanceTo(goal);
	}
public:
	Heap(int size, Vertex* _goal):
		maxSize(size), goal(_goal)
	{
		heap = new Vertex*[size];
		estimate = new double[size](); // Zero initialize double array
		added = new bool[size](); // False initialize bool array

		// Start with infinite estimations, except for the goal
		for (int i = 0; i < size; i++)
		{
			if (i != goal->index) estimate[i] = INFINITY;
		}
	}

	~Heap()
	{
		delete[] heap;
		delete[] estimate;
		delete[] added;
	}

	void add(Vertex* vertex)
	{
		// Prevent array overflow
		if (top == maxSize - 1)
		{
			printf("Error, too many vertices!");
			return;
		}

		// Add value to the heap array
		heap[++top] = vertex;
		// Store index for O(1) lookup
		added[vertex->index] = true;

		// Maintain heap property
		siftUp(top);
	}

	Vertex* smallest()
	{
		// Prevent array underflow
		if (top < 0) return NULL;

		// Remove the first value
		Vertex* first = heap[0];
		added[first->index] = false;

		// Replace the root
		heap[0] = heap[top--];

		// Maintain heap property
		siftDown(0);

		return first;
	}

	void update(double* weights, Vertex* neighbour)
	{
		// Update estimations based on heuristic
		estimate[neighbour->index] = weights[neighbour->index] + heuristic(neighbour);

		// Add neighbour to heap if not already added, O(1) lookup
		if (!added[neighbour->index]) add(neighbour);
	}
};

class Graph
{
private:
	int nVertices, nEdges;
	HashMap vertices;

	double aStar(Vertex* start, Vertex* goal, Edge** edgeList, int& numEdges) // A* algorithm
	{
		// Track discovered vertices with a min heap
		Heap discovered(nVertices, goal);

		// Start with infinite weights, except for the goal vertex
		double* weights = new double[nVertices]();
		for (int i = 0; i < nVertices; i++)
		{
			if (i != goal->index) weights[i] = INFINITY;
		}

		// From goal, check neighbouring vertices until target is reached
		Vertex* currentVertex = goal;
		while (currentVertex != NULL && currentVertex->id != start->id)
		{
			// Check all neighbours of current vertex
			Edge* neighbour = currentVertex->neighbour;
			while (neighbour != NULL)
			{
				// Choose the best total weight relative to goal
				double weight = weights[currentVertex->index] + neighbour->weight;
				if (weight < weights[neighbour->to->index])
				{
					// Update weight for this vertex
					weights[neighbour->to->index] = weight;
					// Set previously visited edge
					neighbour->to->prev = neighbour;
					// Add or update discovered vertices
					discovered.update(weights, neighbour->to);
				}
				// Check next neighbouring vertex
				neighbour = neighbour->next;
			}

			// Move to next smallest estimate and repeat
			currentVertex = discovered.smallest();
		}

		delete[] weights;

		// Calculate total weight from goal to start
		double totalWeight = 0.0;

		Vertex* next = start;
		while (next->prev != NULL)
		{
			// Increment total weight
			totalWeight += next->prev->weight;
			// Store current path of edges
			edgeList[numEdges++] = next->prev;
			// Move to next edge
			next = next->prev->from;
		}

		return totalWeight;
	}

	void printPath(Edge** path, int numEdges, double totalWeight)
	{
		if (totalWeight >= INFINITY)
		{
			printf("\nNo path was found!\n");
		}
		else
		{
			// Calculate and print all edges along path
			printf("\nIncludes %d edges:", numEdges);
			double totalDistance = 0.0; // Calculated for fun
			for (int i = 0; i < numEdges; i++)
			{
				double distance = path[i]->to->distanceTo(path[i]->from);
				printf("\nEdge %d => %d (weight: %g, distance: %lf)", path[i]->to->id, path[i]->from->id, path[i]->weight, distance);
				totalDistance += distance;
			}
			printf("\n\nTotal weight: %g\n", totalWeight);
			printf("Total distance: %lf\n", totalDistance);
		}
	}
public:
	Graph(int _nVertices, int _nEdges):
		nVertices(_nVertices), nEdges(_nEdges), vertices(_nVertices)
	{}

	void addVertex(int id, double x, double y)
	{
		// Handled by hashmap to resolve ID collisions
		vertices.add(id, x, y);
	}

	void addEdge(int startID, int endID, double weight)
	{
		// Look up vertices using hashmap
		Vertex* start = vertices.get(startID);
		Vertex* end = vertices.get(endID);

		start->connectTo(end, weight);

		// Undirected graphs have two-way connections
		#ifdef UNDIRECTED
			end->connectTo(start, weight);
		#endif
	}

	void process(int startID, int goalID)
	{
		// Print number of vertices and edges
		printf("\nNumber of vertices: %d", nVertices);
		printf("\nNumber of edges: %d\n", nEdges);

		Vertex* start = vertices.get(startID);
		Vertex* goal = vertices.get(goalID);

		// Print start, goal, and the distance between them
		printf("\nStart vertex\nID: %d, X: %g, Y: %g\n", start->id, start->x, start->y);
		printf("\nGoal vertex\nID: %d, X: %g, Y: %g\n", goal->id, goal->x, goal->y);
		printf("\nStart to goal distance: %lf\n", start->distanceTo(goal));

		printf("\n=== FIRST SHORTEST PATH ===\n");

		// Store all visited edges to calculate second shortest path
		Edge** edgeList = new Edge*[nVertices];
		int numEdges = 0;

		double totalWeight = aStar(start, goal, edgeList, numEdges);
		printPath(edgeList, numEdges, totalWeight);

		printf("\n=== SECOND SHORTEST PATH ===\n");

		// Remove an edge to find the second shortest path
		double bestWeight = INFINITY;
		Edge** bestPath = NULL;
		int bestEdges = 0;

		// Test all possible removals in order (E - e0, E - e1, E - e2...)
		for (int i = 0; i < numEdges; i++)
		{
			// Store the weight
			double prevWeight = edgeList[i]->weight;

			// Remove the edge by making it a poor choice
			edgeList[i]->weight = INFINITY;

			// Track all visited edges
			Edge** currentPath = new Edge*[nVertices];
			int currentEdges = 0;

			// Run the algorithm again
			totalWeight = aStar(start, goal, currentPath, currentEdges);

			// Keep result only if new path is shorter
			if (totalWeight < bestWeight)
			{
				delete[] bestPath;
				bestPath = currentPath;
				bestEdges = currentEdges;
				bestWeight = totalWeight;
			}
			else
			{
				delete[] currentPath;
			}

			// Reset the weight
			edgeList[i]->weight = prevWeight;
		}

		delete[] edgeList;

		// Print best result from all trials
		printPath(bestPath, bestEdges, bestWeight);

		delete[] bestPath;
	}
};

int main()
{
	// Request filename from user
	char fileName[100];
	printf("Enter the filename: ");
	scanf("%s", fileName);

	// Ensure the file can be opened
	FILE* textFile = fopen(fileName, "r");
	if (textFile == NULL)
	{
		perror("Error, cannot open file!");
		return 1;
	}

	// Read number of vertices and edges
	int nVertices, nEdges;
	fscanf(textFile, "%d %d", &nVertices, &nEdges);

	// Create a graph object
	Graph graph(nVertices, nEdges);

	// Read vertices, assuming strict format
	int id;
	double x, y;
	for (int i = 0; i < nVertices; i++)
	{
		fscanf(textFile, "%d %lf %lf", &id, &x, &y);

		// Add vertex to graph
		graph.addVertex(id, x, y);
	}

	// Read edges, assuming strict format
	int start, end;
	double weight;
	for (int j = 0; j < nEdges; j++)
	{
		fscanf(textFile, "%d %d %lf", &start, &end, &weight);

		// Add edge to graph
		graph.addEdge(start, end, weight);
	}

	// Read start and goal
	int goal;
	fscanf(textFile, "%d %d", &start, &goal);

	// Calculate and print paths
	graph.process(start, goal);

	return 0;
}
