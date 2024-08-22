#include <vector>
#include <set>
#include <queue>
#include <utility>
using namespace std;

using Coord = pair<int,int>;
using DistCoord = pair<int,Coord>;


/// @brief Returns the shortest path from the source note to the goal
/// @param grid The vector representation of the distances 
/// @return int The shortest path from source to goal
int shortestPath(const vector<vector<int>> &grid);