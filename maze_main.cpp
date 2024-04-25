#include <iostream>
#include <stack>
#include "olcConsoleGameEngine.h"

class OneLoneCoder_Maze : public olcConsoleGameEngine {  // inheriting members (methods & variables) from olcConsoleGameEngine
public:
    OneLoneCoder_Maze() {  // constructor
        m_sAppName = L"MAZE";  // L"MAZE" is a string literal & m_sAppName is from the parent class

        // A string literal is represented under wchar_t data type. Each char in the string literal occupies two bytes of memory
        // this allows the string to handle unicode characters (something with windows API)
    }

private:
    int m_nMazeWidth;  // stores width of maze
    int m_nMazeHeight;  // stores height of maze
    int *m_maze;  // dynamic array that stores values for all cells to store neighbors each cell is connected to
    // a dynamic array is basically just an array that changes its size dynamically during run time

    enum {  // enum is short for enumeration. user defined data type that contains constant vals
        CELL_PATH_N = 0x01,  // each cell has a bitmask (in hex notation) represents its state
        CELL_PATH_E = 0x02,  // Represents 00000010 in binary
        CELL_PATH_S = 0x04,  // Represents 00000100 in binary
        CELL_PATH_W = 0x08,
        CELL_VISITED = 0x10,
    };

    int m_nVisitedCells;  // keeps track of the cells visited

    stack<std::pair<int, int>> m_stack; // stack that keeps track of movement throughout the maze
    //  the pair is to store the (x,y) coords of the maze grid

protected:  // different from 'private' as stuff in 'protected' can be accessed by classes derived from this class
    virtual bool OnUserCreate() {  // virtual creates a universal function that can be modified by other classes
        // Maze Parameters
        m_nMazeWidth = 40;
        m_nMazeHeight = 25;

        return true;
    }

    virtual bool OnUserUpdate(float fElapsedTime) {
        return true;
    }

};

int main() {

    OneLoneCoder_Maze game;
    game.ConstructConsole(160, 100, 8, 8);
    game.Start();

    return 0;
}