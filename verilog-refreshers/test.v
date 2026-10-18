// 1. Define the module to test (A simple AND gate)
module and_gate (
    input wire a,
    input wire b,
    output wire y
);
    assign y = a & b;
endmodule

// 2. Define the Testbench
module testbench;
    // Inputs to the AND gate (declared as regs to change their values)
    reg a;
    reg b;
    // Output from the AND gate
    wire y;

    // Instantiate the Unit Under Test (UUT)
    and_gate uut (
        .a(a),
        .b(b),
        .y(y)
    );

    initial begin
        // Tell Icarus Verilog to dump the waveforms for GTKWave
        $dumpfile("waveform.vcd");
        $dumpvars(0, testbench);

        // Display a header in the terminal
        $display("Time\t A \t B \t Y");
        $monitor("%0t\t %b \t %b \t %b", $time, a, b, y);

        // Test vectors
        a = 0; b = 0; #10;
        a = 0; b = 1; #10;
        a = 1; b = 0; #10;
        a = 1; b = 1; #10;

        // End simulation
        $finish;
    end
endmodule
