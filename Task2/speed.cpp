#include <iostream>
#include <fstream>

#include "shortestPath.h"
using namespace std;

int main(int argc, char* argv[]){
    string text;
    ifstream myFile(argv[1]);
    vector<vector<int>> holder;
    int i = 0;

    // reading lines from file
    while(getline (myFile, text)){
        holder.push_back({});
        for(char c: text){
            // converting the char to an int, constructing the 2D vector
            holder[i].push_back(c - '0');
        }
        ++i;
    }
    cout << shortestPath(holder) << endl;
    return 0;
}