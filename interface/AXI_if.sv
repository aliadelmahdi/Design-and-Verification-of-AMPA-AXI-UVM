// Comments referenced I used are from the ARM AMBA AXI4 specifications  
// For detailed information on the AMBA® AXI4 interface, refer to the official ARM specification:
// http://www.gstitt.ece.ufl.edu/courses/fall15/eel4720_5721/labs/refs/AXI4_specification.pdf
import shared_pkg::*; // For enums and parameters

interface AXI_if (input bit aclk);

  `include "AXI_globals.svh"   // Global parameters for AXI interface
  `include "AXI_ar.svh"        // Read Address (AR) channel signal definitions
  `include "AXI_r.svh"         // Read Data (R) channel signal definitions
  `include "AXI_aw.svh"        // Write Address (AW) channel signal definitions
  `include "AXI_w.svh"         // Write Data (W) channel signal definitions
  `include "AXI_b.svh"         // Write Response (B) channel signal definitions

  `include "AXI_modports.svh"  // AXI interface modport definitions for master/slave directions

endinterface : AXI_if