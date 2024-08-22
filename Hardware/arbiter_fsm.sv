module arbiter_fsm (
    input logic clock,          // Clock signal
    input logic [3:1] r,        // 3-bit input vector
    input logic resetn,         // Active low reset
    output logic [3:1] g        // (g3, g2, g1) 1-hot output state

);

    // Define state encoding
    typedef enum logic [3:1] {
        A = 3'b000,   // State A
        B = 3'b001,   // State B
        C = 3'b010,   // State C
        D = 3'b100    // State D
    } state_t;

    state_t current_state, next_state;

    // Combinational logic to determine next state
    always_comb begin
        case (current_state)
            A: begin
                case (r)
                    3'b000: next_state = A;
                    3'b001: next_state = B;
                    3'b010: next_state = C;
                    3'b011: next_state = B;
                    3'b100: next_state = D;
                    3'b101: next_state = B;
                    3'b110: next_state = C;
                    3'b111: next_state = B;
                    // default: next_state = A;
                endcase
            end

            B: begin
                case (r)
                    3'b000: next_state = A;
                    3'b001: next_state = B;
                    3'b010: next_state = A;
                    3'b011: next_state = B;
                    3'b100: next_state = A;
                    3'b101: next_state = B;
                    3'b110: next_state = A;
                    3'b111: next_state = B;
                    // default: next_state = A;
                endcase
            end

            C: begin
                case (r)
                    3'b000: next_state = A;
                    3'b001: next_state = A;
                    3'b010: next_state = C;
                    3'b011: next_state = C;
                    3'b100: next_state = A;
                    3'b101: next_state = A;
                    3'b110: next_state = C;
                    3'b111: next_state = C;
                    // default: next_state = A;
                endcase
            end

            D: begin
                case (r)
                    3'b000: next_state = A;
                    3'b001: next_state = A;
                    3'b010: next_state = A;
                    3'b011: next_state = A;
                    3'b100: next_state = D;
                    3'b101: next_state = D;
                    3'b110: next_state = D;
                    3'b111: next_state = D;
                    // default: next_state = A;
                endcase
            end

            default: next_state = A;  // Default to state A
        endcase
    end

    // Sequential logic to update state on clock edge
    always_ff @(posedge clock) begin
        if (resetn) begin
            current_state <= next_state;
            g <= current_state;  // Output the current state
        end else begin
            current_state <= A;
            g <= A;
        end
    end

endmodule
