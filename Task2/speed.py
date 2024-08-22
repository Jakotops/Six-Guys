from queue import PriorityQueue

def string2vec(inp):
    out = []
    line = []
    for c in inp:
        if c == '\n':
            out.append(line)
            line = []
        else:
            line.append(int(c))
    out.append(line)
    return out


def shortestPath(grid):
    visited = set()
    visited.add((0,0))
    toVisit = PriorityQueue()
    toVisit.put((grid[0][0], (0,0)))
    height = len(grid)
    width = len(grid[0])
    goal = (height-1, width-1)
    while (not (goal in visited)):
        distance, current = toVisit.get()
        if (current[0] > 0):
            next = (current[0]-1, current[1])
            if (next == goal):
                return distance + grid[next[0]][next[1]]
            if (not(next in visited)):
                toVisit.put((distance + grid[next[0]][next[1]], next))
                visited.add(next)
        if (current[1] > 0):
            next = (current[0], current[1]-1)
            if (next == goal):
                return distance + grid[next[0]][next[1]]
            if (not(next in visited)):
                toVisit.put((distance + grid[next[0]][next[1]], next))
                visited.add(next)
        if (current[0] < height-1):
            next = (current[0]+1, current[1])
            if (next == goal):
                return distance + grid[next[0]][next[1]]
            if (not(next in visited)):
                toVisit.put((distance + grid[next[0]][next[1]], next))
                visited.add(next)
        if (current[1] < width-1):
            next = (current[0], current[1]+1)
            if (next == goal):
                return distance + grid[next[0]][next[1]]
            if (not(next in visited)):
                toVisit.put((distance + grid[next[0]][next[1]], next))
                visited.add(next)
        


# test = [[1,1,6,3,7,5,1,7,4,2],
#         [1,3,8,1,3,7,3,6,7,2],
#         [2,1,3,6,5,1,1,3,2,8],
#         [3,6,9,4,9,3,1,5,6,9],
#         [7,4,6,3,4,1,7,1,1,1],
#         [1,3,1,9,1,2,8,1,3,7],
#         [1,3,5,9,9,1,2,4,2,1],
#         [3,1,2,5,4,2,1,6,3,9],
#         [1,2,9,3,1,3,8,5,2,1],
#         [2,3,1,1,9,4,4,5,8,1]]

test = '''1163751742
1381373672
2136511328
3694931569
7463417111
1319128137
1359912421
3125421639
1293138521
2311944581'''
print(shortestPath(string2vec(test)))