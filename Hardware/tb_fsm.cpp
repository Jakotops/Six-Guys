#include "Varbiter_fsm.h"    // Include the generated model header
#include "verilated.h"
#include <random>

int main(int argc, char **argv, char **env) {
    std::random_device rd;

    // Choose a random number between 0 and 3
    std::mt19937 gen(rd()); // Mersenne Twister engine
    std::uniform_int_distribution<> distrib(0, 7);

    // Initialize Verilators variables
    Verilated::commandArgs(argc, argv);

    // Instantiate the model
    Varbiter_fsm* top = new Varbiter_fsm;

    // Set the initial input values
    top->clock = 0;
    top->r = 0;
    top->resetn = 1;
    printf("clock  period set to 2s (0.5Hz)\n");
    // Simulate over several clock cycles
    int counter = 0;

    //note that each clock period is 0.5i. So if you want 50 clock periods, set i <100
    for (int i = 0; i < 100; i++) {
        // Toggle the clock
        top->clock = !top->clock;

        // Evaluate the model
        top->eval();

        // Apply inputs on the negative edge of the clock
        if (!top->clock) {
            // set input signals
            int random_number = distrib(gen);
            if (i == 0){//force initial input to be 0
                random_number = 0;
            }
            top->r = random_number;
        }

        //represent states in their character form
        char state_char;
        switch (top->g)
        {
        case 0:
            state_char = 'A';
            break;
        case 1:
            state_char = 'B';
            break;
        case 2:
            state_char = 'C';
            break;
        case 4:
            state_char = 'D';
            break;

        default:
            break;
        }

        if (top->clock){
            // Optionally print the output or state for debugging
            if (i == 0){//intiial state
                printf("time t%3i: initial_state = %c (%i) input = %i (%i %i %i)\n", counter, state_char,top->g, top->r,(top->r>>2) &1,(top->r>>1) &1,(top->r>>0) &1);
            }
            else{
                printf("time t%3i: current_state = %c (%i) input = %i (%i %i %i)\n", counter, state_char,top->g, top->r,(top->r>>2) &1,(top->r>>1) &1,(top->r>>0) &1);
            }
            counter +=1;
        }

    }

    // Final model cleanup
    top->final();

    // Cleanup
    delete top;
    return 0;
}
