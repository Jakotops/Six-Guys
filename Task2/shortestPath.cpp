#include "shortestPath.h"

int shortestPath(const vector<vector<int>> &grid){
    // set of visited coordinates
    set<Coord> visited;
    visited.insert(Coord(0,0));

    // priority queue of coordinates to be visited
    priority_queue<pair<int, Coord>, vector<pair<int, Coord>>, greater<pair<int, Coord>>> toVisit;
    toVisit.push(DistCoord(grid[0][0], Coord(0,0)));

    const int height = grid.size();
    const int width = grid[0].size();

    // the end
    const Coord goal = Coord(height-1, width-1);

    // declaring variables to be used in the while loop
    pair<int, Coord> temp;
    int distance;
    Coord current, next;
    while (!visited.count(goal)){
        // extracting the current distance and coordinate from the queue
        temp = toVisit.top();
        distance = temp.first;
        current = temp.second;
        toVisit.pop();

        // if there's space to go left, go left
        if (current.first > 0){
            next = Coord(current.first-1, current.second);
            if (next == goal){
                // if we've reached the goal, output the answer
                return distance + grid[next.first][next.second];
            }
            if (!visited.count(next)){
                toVisit.push(DistCoord(distance + grid[next.first][next.second], next));
                visited.insert(next);
            }
        }

        // if there's space to go up, go up
        if (current.second > 0){
            next = Coord(current.first, current.second-1);
            if (next == goal){
                return distance + grid[next.first][next.second];
            }
            if (!visited.count(next)){
                toVisit.push(DistCoord(distance + grid[next.first][next.second], next));
                visited.insert(next);
            }
        }
        if (current.first < height-1){
            next = Coord(current.first+1, current.second);
            if (next == goal){
                return distance + grid[next.first][next.second];
            }
            if (!visited.count(next)){
                toVisit.push(DistCoord(distance + grid[next.first][next.second], next));
                visited.insert(next);
            }
        }
        if (current.second < width-1){
            next = Coord(current.first, current.second+1);
            if (next == goal){
                return distance + grid[next.first][next.second];
            }
            if (!visited.count(next)){
                toVisit.push(DistCoord(distance + grid[next.first][next.second], next));
                visited.insert(next);
            }
        }
    }
    return 0;
}