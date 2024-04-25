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

protected:  // different from 'private' as stuff in 'protected' can be accessed by classes derived from this class
    virtual bool OnUserCreate() {  // virtual creates a universal function that can be modified by other classes
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