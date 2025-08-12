# AXI Test Suite (UVM)

This folder contains all **UVM-based tests** for verifying the AMBA AXI4 master implementation.  
It builds on a **base test** that sets up the environment and provides helper methods, with derived tests targeting specific protocol areas.

---

## **Test Overview**

| Test Name                | Purpose | Key Scenarios | Checks | Coverage Focus |
|--------------------------|---------|---------------|--------|----------------|
| **AXI_test_base**        | Common base class providing environment creation, config hookup, and utility tasks for running sequences. | — | — | — |
| **AXI_smoke_test**       | Basic connectivity & sanity check. | Single-beat reads/writes, minimal sequences. | Handshake correctness, data path wiring. | Initial bring-up. |
| **AXI_burst_modes_test** | Burst mode functionality & legality. | INCR/FIXED/WRAP, max-len, unaligned, boundary-crossing. | Address progression, LEN/SIZE/BURST legality. | Burst types × sizes × alignments. |
| **AXI_flow_control_test**| Flow control and channel independence. | Backpressure, partial strobes, RAW/WAR ordering. | No deadlocks, correct strobe/data alignment. | Backpressure × strobe patterns × burst types. |
| **AXI_robustness_test**  | Behavior under error & stress. | Error injection, mid-transaction reset, random stress. | Error handling, reset recovery, liveness. | Error codes × timing × channel states. |

---

## **Structure**

```

verification/tests/
├── AXI_test_pkg.sv            # Test package importing env & shared utilities
├── AXI_test_base.svh          # Base test class
├── AXI_smoke_test.svh         # Basic sanity test
├── AXI_burst_modes_test.svh   # Burst mode scenarios
├── AXI_flow_control_test.svh  # Flow control and interleaving
└── AXI_robustness_test.svh    # Error, reset, and stress handling

```

---

## **Key Features**
- **Configurable environment** — master active, slave passive by default.
- **Reusable helpers** for running master sequences.
- **Protocol compliance checks** via assertions.
- **Functional coverage bins** for burst modes, strobes, alignment, and error scenarios.
- **Stress & robustness verification** with random traffic.

---

## **Usage Notes**
- Always start with **`AXI_smoke_test`** after integration to ensure the bench is wired correctly.
- Run targeted tests (`burst_modes`, `flow_control`) before stress tests for easier debug.
- Enable full coverage collection when running robustness tests.