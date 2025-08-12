// -----------------------------------------------------------------------------
// verification/tests/AXI_test_pkg.sv
// AXI Test Package
//
// Contains a base test and a focused test suite covering:
//   - Smoke (basic sanity for reads/writes)
//   - Burst modes (INCR/FIXED/WRAP, max-len, unaligned, boundary-cross)
//   - Flow control (strobes, interleaving, backpressure, RAW/WAR timing)
//   - Robustness (protocol errors, reset mid-transaction, random stress)
// -----------------------------------------------------------------------------
package AXI_test_pkg;
  import uvm_pkg::*;
  import AXI_env_pkg::*;
  import shared_pkg::*;  // Shared typedefs, parameters, utilities (addr_t, data_t, sizes, etc.)

  // ---------------------------------------------------------------------------
  // Base Test
  // Provides:
  //   - env creation & config hookup (master active, slave passive)
  //   - virtual interface fetch via uvm_config_db
  //   - default master reset sequence before scenarios
  //   - helpers (e.g., run_on_master) for derived tests
  // Derived tests override run_scenarios() to provide stimulus.
  // ---------------------------------------------------------------------------
  `include "AXI_test_base.svh"

  // ---------------------------------------------------------------------------
  // AXI_smoke_test
  // Goal: Quick sanity that the bench is wired correctly and the master can
  //       perform minimal legal AXI traffic.
  // Sequences:
  //   - AXI_master_main_sequence: small default sequence (basic read/write)
  //   - AXI_master_single_read_seq: single-beat read
  //   - AXI_master_single_write_seq: single-beat write
  // Checks:
  //   - Handshake correctness (VALID/READY)
  //   - Data path plumbed (write passes through, read returns expected data)
  //   - No fatal config or env issues before deeper tests
  // Typical use: First test you run after integration.
  // ---------------------------------------------------------------------------
  `include "AXI_smoke_test.svh"

  // ---------------------------------------------------------------------------
  // AXI_burst_modes_test
  // Goal: Validate that the master drives legal bursts under different modes
  //       and boundary conditions.
  // Sequences:
  //   - AXI_master_incr_burst_seq        : INCR bursts over multiple beats
  //   - AXI_master_fixed_burst_seq       : FIXED bursts (addr constant across beats)
  //   - AXI_master_wrap_burst_seq        : WRAP bursts with correct wrap boundaries
  //   - AXI_master_max_len_burst_seq     : Max-length bursts per AXI limits
  //   - AXI_master_unaligned_access_seq  : Unaligned start addresses with legal behavior
  //   - AXI_master_boundary_cross_seq    : Boundary-crossing behavior (4k or configured)
  // Checks:
  //   - Addr progression per burst type
  //   - LEN/SIZE/BURST legality
  //   - No illegal boundary crossing; wrap math correct
  // Coverage:
  //   - Burst types × sizes × lengths × alignment/boundary bins
  // ---------------------------------------------------------------------------
  `include "AXI_burst_modes_test.svh"

  // ---------------------------------------------------------------------------
  // AXI_flow_control_test
  // Goal: Stress VALID/READY flow control and byte-lane enables.
  // Sequences:
  //   - AXI_master_partial_write_strobe_seq : Partial byte strobes on WSTRB
  //   - AXI_master_interleaved_rw_seq       : Read/write interleaving on channels
  //   - AXI_master_read_backpressure_seq    : Apply R channel backpressure (RREADY throttling)
  //   - AXI_master_write_backpressure_seq   : Apply W/B channel backpressure
  //   - AXI_master_read_after_write_seq     : RAW timing (read immediately after write)
  //   - AXI_master_write_after_read_seq     : WAR timing (write immediately after read)
  // Checks:
  //   - Correct strobe masking and data alignment
  //   - No deadlock with READY deassertions
  //   - Correct ordering/response when channels stall independently
  // Coverage:
  //   - Backpressure patterns × channel × burst type × strobe patterns
  // ---------------------------------------------------------------------------
  `include "AXI_flow_control_test.svh"

  // ---------------------------------------------------------------------------
  // AXI_robustness_test
  // Goal: Prove the master behaves predictably under “nasty” conditions.
  // Sequences:
  //   - AXI_master_error_probe_seq      : Inject protocol/response errors (e.g., SLVERR/DECERR)
  //   - AXI_master_reset_during_txn_seq : Assert reset in-flight and recover cleanly
  //   - AXI_master_random_stress_seq    : High-load randomized traffic (mix R/W, sizes, lengths)
  // Checks:
  //   - Graceful handling/reporting of error responses
  //   - Proper quiesce and restart across reset (no stuck VALIDs, state resets to IDLE)
  //   - Liveness under stress (no starvation/deadlock), responses match requests
  // Coverage:
  //   - Error codes × locations × timing points
  //   - Reset timing vs. channel/state
  //   - Stress mixes across lengths/sizes/addresses
  // ---------------------------------------------------------------------------
  `include "AXI_robustness_test.svh"

endpackage
