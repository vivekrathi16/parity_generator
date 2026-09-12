`timescale 1ns/1ps

module parity_generator_tb;

    // Testbench signals
    logic [7:0] data;
    logic       parity;

    // Expected output
    logic       expected_parity;

    // Counters
    int pass_count = 0;
    int fail_count = 0;

    // Loop variable
    int i;


    // DUT Instantiation
    parity_generator dut (
        .data   (data),
        .parity (parity)
    );


    initial begin

        // Save waveform
        $dumpfile("parity_generator.vcd");
        $dumpvars(0, parity_generator_tb);


        $display("========================================");
        $display("   PARITY GENERATOR TESTBENCH STARTED");
        $display("========================================");


        // Test all 256 input combinations
        for (i = 0; i < 256; i++) begin

            data = i[7:0];

            // Calculate expected parity
            expected_parity = ^data;

            #10;


            // Check result
            if (parity === expected_parity) begin

                pass_count++;

                $display(
                    "PASS | Data = %b | Parity = %b",
                    data,
                    parity
                );

            end
            else begin

                fail_count++;

                $display(
                    "FAIL | Data = %b | Expected = %b | Actual = %b",
                    data,
                    expected_parity,
                    parity
                );

            end

        end


        // Final Summary
        $display("========================================");
        $display("        SIMULATION SUMMARY");
        $display("========================================");

        $display("Total Test Cases = %0d",
                  pass_count + fail_count);

        $display("Passed           = %0d", pass_count);
        $display("Failed           = %0d", fail_count);

        $display("========================================");


        if (fail_count == 0)
            $display("RESULT: ALL TEST CASES PASSED!");
        else
            $display("RESULT: TEST FAILED!");

        $display("========================================");


        $finish;

    end

endmodule
