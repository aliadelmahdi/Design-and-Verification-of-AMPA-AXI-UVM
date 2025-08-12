`ifndef AXI_DEFINES_SVH
`define AXI_DEFINES_SVH

        // Basic logic levels
        `define LOW 0
        `define HIGH 1

        // ON/OFF control for active low signals
        `define ON_n 0
        `define OFF_n  1

        // Read/Write control
        `define WRITE 1
        `define READ  0

        // Common test data patterns
        `define WDATA_ALL_ZERO   32'h0000_0000  // All zeros
        `define WDATA_ALL_ONE    32'hFFFF_FFFF  // All ones
        `define WDATA_ALT_1010   32'hAAAA_AAAA  // Alternating 1010 pattern
        `define WDATA_ALT_0101   32'h5555_5555  // Alternating 0101 pattern

        // Probability values for test scenarios
        `define WRITE_PROB 70  // 70% chance of write operation
        `define READ_PROB  30  // 30% chance of read operation

        // Memory settings
        `define MEM_DEPTH 1024  // Number of memory locations
        `define MEM_WIDTH 32    // Width of each memory location in bits

        // Simulation control
        `define DISABLE_FINISH 0  // Keep Questa simulation running
        `define ENABLE_FINISH 1   // Close Questa simulation when done

        // Clock period definition
        `define CLK_PERIOD 10  // Clock period in time units

        // Test iterations
        `define TEST_ITER_SMALL   100    // Small number of iterations
        `define TEST_ITER_MEDIUM  1_000   // Medium-sized test
        `define TEST_ITER_LARGE   2_000  // Large-scale test
        `define TEST_ITER_STRESS  5_000 // Stress test

        // Timescale control
        `define TIME_UNIT 1ps
        `define TIME_PRECISION 1ps

        `define display_separator \
                $display("====================================================================================");

        // Constraint Mode ON/OFF
        `define enable_constraint(constraint) \
                seq_item.constraint.constraint_mode(`ON);
        `define disable_constraints  \
                seq_item.constraint_mode(`OFF);
        `define enable_constraints  \
                seq_item.constraint_mode(`ON);
        `define disable_constraint(constraint) \
                seq_item.constraint.constraint_mode(`OFF);

        // Enable randomization for a specific field in seq_item
        `define enable_rand(field) \
                seq_item.field.rand_mode(`ON);

        // Disable randomization for a specific field in seq_item
        `define disable_rand(field) \
                seq_item.field.rand_mode(`OFF);

        // Enable randomization for all fields in seq_item
        `define enable_rand_all \
                seq_item.rand_mode(`ON);

        // Disable randomization for all fields in seq_item
        `define disable_rand_all \
                seq_item.rand_mode(`OFF);

`endif // AXI_DEFINES_SVH
