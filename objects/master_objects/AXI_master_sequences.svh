`ifndef AXI_MASTER_SEQUENCES_SVH
`define AXI_MASTER_SEQUENCES_SVH

// ============================================================
// AXI Master Sequences Package
// This package includes all standard, directed, and stress-test
// sequences that can be run by the AXI master in the UVM testbench.
// ============================================================

`include "AXI_master_reset_sequence.svh"           
// Resets the AXI master interface signals to a known idle state.
// Ensures all handshake lines are deasserted and internal variables
// are initialized before starting transactions.

`include "AXI_master_main_sequence.svh"            
// Main randomized stimulus generator for the AXI master.
// Produces a mix of read and write transactions with varying lengths,
// burst types, and addresses according to user-defined constraints.

// ----------------------
// Directed and Specialized Sequences
// ----------------------

`include "AXI_master_single_read_seq.svh"          
// Issues single-beat (len=1) read transactions to verify basic read
// path functionality and check simple data transfer correctness.

`include "AXI_master_single_write_seq.svh"         
// Issues single-beat (len=1) write transactions to verify basic write
// path functionality and correct data placement in the slave.

`include "AXI_master_incr_burst_seq.svh"           
// Generates incrementing address bursts (BURST_INCR) to test sequential
// memory access and proper burst increment behavior.

`include "AXI_master_fixed_burst_seq.svh"          
// Generates fixed-address bursts (BURST_FIXED) to ensure data is written
// repeatedly to the same address, useful for FIFO-style slaves.

`include "AXI_master_wrap_burst_seq.svh"           
// Generates wrapping address bursts (BURST_WRAP) to verify the master's
// ability to wrap addresses correctly over a defined burst boundary.

`include "AXI_master_max_len_burst_seq.svh"        
// Generates the maximum allowed burst length for the configured AXI
// parameters to test boundary conditions and slave buffering limits.

`include "AXI_master_unaligned_access_seq.svh"     
// Issues transactions with addresses not aligned to the data width.
// Verifies that the system handles unaligned accesses per AXI spec.

`include "AXI_master_boundary_cross_seq.svh"       
// Tests transactions that cross 4KB boundaries, ensuring the master
// correctly follows AXI restrictions and address increment rules.

`include "AXI_master_partial_write_strobe_seq.svh" 
// Issues write transactions with partial write strobes (WSTRB) set,
// verifying correct byte-enable support in the slave.

`include "AXI_master_interleaved_rw_seq.svh"       
// Interleaves read and write transactions to different addresses to
// stress-test arbitration, ordering, and throughput.

`include "AXI_master_read_backpressure_seq.svh"    
// Simulates backpressure from the master side during read data transfers
// by controlling RREADY to test slave's flow control handling.

`include "AXI_master_write_backpressure_seq.svh"   
// Simulates backpressure from the master side during write data transfers
// by controlling WREADY to verify correct handling of stalls.

`include "AXI_master_read_after_write_seq.svh"     
// Performs a read immediately after a write to the same address,
// verifying data coherency and memory update timing.

`include "AXI_master_write_after_read_seq.svh"     
// Performs a write immediately after a read to the same address,
// testing timing interactions and possible hazards.

`include "AXI_master_error_probe_seq.svh"          
// Generates transactions targeted to trigger slave error responses
// (e.g., DECERR, SLVERR) to validate error-handling logic.

`include "AXI_master_reset_during_txn_seq.svh"     
// Asserts a reset in the middle of active transactions to verify
// that the design recovers gracefully without protocol violations.

`include "AXI_master_random_stress_seq.svh"        
// Generates high-volume randomized read/write traffic with varied
// burst types, lengths, and addresses to stress-test the entire AXI
// system under unpredictable conditions.

`endif // AXI_MASTER_SEQUENCES_SVH