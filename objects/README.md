# 📦 UVM Transaction Objects

This folder contains **sequence items** and **sequences** for the AXI master and slave agents.

**Contents:**
- `AXI_config.sv` – Shared UVM configuration object for master/slave agents (stores virtual interface handle, activity mode, etc.).
- `master_objects/` – Master-side sequence items and **all master sequences** (reset, main randomized traffic, and directed sequences).
- `slave_objects/` – Slave-side sequence items and sequences.

Objects define the **transaction-level representation** of AXI bus operations and how sequences drive them.

---

## 📜 Master Sequences Overview
The AXI master has a **comprehensive set of sequences** for different traffic scenarios and verification goals.

### **Core Sequences**
- **`AXI_master_reset_sequence`** – Applies a reset sequence on the master interface. Ensures all channels return to their idle state, counters are cleared, and initial protocol conditions are met before traffic begins.
- **`AXI_master_main_sequence`** – Generates general **randomized AXI read and write transactions** with varying lengths, addresses, and bursts for broad coverage of protocol features.

---

### **Scenario Sequences**

- **`AXI_master_single_read_seq`** – Issues **single-beat read** transactions (burst length = 1) to verify simple address/data handshakes and correct single-transfer behavior.<br><br>

- **`AXI_master_single_write_seq`** – Sends **single-beat write** transactions to test basic write operations and response handling.<br><br>

- **`AXI_master_incr_burst_seq`** – Generates **incrementing address bursts** (BURST_INCR), ensuring the master increments the address correctly per beat.<br><br>

- **`AXI_master_fixed_burst_seq`** – Tests **fixed address bursts** (BURST_FIXED) where all beats target the same address, used in FIFOs or peripheral access.<br><br>

- **`AXI_master_wrap_burst_seq`** – Creates **wrapping bursts** (BURST_WRAP) to verify correct wrap-around addressing behavior according to AXI rules.<br><br>

- **`AXI_master_max_len_burst_seq`** – Uses the **maximum allowed burst length** (per AXI spec) to stress-test address generation and data throughput.<br><br>

- **`AXI_master_unaligned_access_seq`** – Sends transactions where the address is **not aligned** to the transfer size, testing address alignment handling and potential error signaling.<br><br>

- **`AXI_master_boundary_cross_seq`** – Issues bursts that **cross 4KB or other alignment boundaries**, verifying that the master/systems handle split or restricted bursts.<br><br>

- **`AXI_master_partial_write_strobe_seq`** – Generates writes with **partial byte strobes** (e.g., 0xF0 or 0x0F) to check byte-enable behavior and selective data updates.<br><br>

- **`AXI_master_interleaved_rw_seq`** – Runs **reads and writes interleaved** to test channel independence and ordering constraints.<br><br>

- **`AXI_master_read_backpressure_seq`** – Applies **backpressure on the read data channel** by deasserting `RREADY` intermittently, verifying stall handling.<br><br>

- **`AXI_master_write_backpressure_seq`** – Applies **backpressure on the write data channel** by deasserting `WREADY`, testing stall handling in writes.<br><br>

- **`AXI_master_read_after_write_seq`** – Issues a **read immediately after a write** to the same or related addresses, checking data coherency and ordering.<br><br>

- **`AXI_master_write_after_read_seq`** – Issues a **write immediately after a read**, verifying proper turnaround and channel readiness.<br><br>

- **`AXI_master_error_probe_seq`** – Intentionally sends accesses to **invalid or protected addresses** to provoke error responses (`SLVERR`, `DECERR`) from the slave.<br><br>

- **`AXI_master_reset_during_txn_seq`** – Applies a **reset while a transaction is active** to test graceful recovery and proper abort behavior.<br><br>

- **`AXI_master_random_stress_seq`** – Generates **high-volume, mixed, and randomized traffic** (varied burst types, lengths, and addresses) to maximize coverage and stress the DUT.<br><br>



---

## 📜 Slave Sequences Overview
Currently, the slave side supports:
- **`AXI_slave_main_sequence`** – Generates **randomized slave responses** to master transactions. Can be extended to model different slave behaviors such as delays, error responses, or data-dependent processing.

---

> **Tip for Test Writers:**  
> - Use **directed sequences** when verifying a specific feature or debugging an issue.  
> - Use **`AXI_master_random_stress_seq`** for coverage closure and regression testing.  
> - All sequences can be combined in `AXI_test_base` or extended test classes for complex test scenarios.