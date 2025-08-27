
# Verilog Digital Clock Display Modules
![Untitled-1-01](https://github.com/user-attachments/assets/e6b81d25-b5c1-437e-856d-b4ee5f56dc9a)
## Overview

This Verilog project implements a digital clock display system for FPGA boards, specifically designed for Spartan-3 FPGAs that have limitations with division and modulus operations. The system converts binary time values to BCD format and drives a 7-segment display to show hours and minutes.

## Project Structure

### Main Modules

1. **`impmain.v`** - An Example of the module that integrates all components
2. **`sevenseg_sel.v`** - Display selector and data multiplexer
3. **`sevenseg_data_driver.v`** - 7-segment display decoder
4. **`binary_to_bcd.v`** - Binary to BCD converter

## Module Descriptions

### 1. binary_to_bcd.v

Converts 9-bit binary values to BCD digits using a shift-and-add-3 algorithm.

**Ports:**
- `input [8:0] binary` - 9-bit binary input (0-511)
- `output reg [3:0] hundreds` - Hundreds digit (BCD)
- `output reg [3:0] tens` - Tens digit (BCD)
- `output reg [3:0] ones` - Ones digit (BCD)

**Features:**
- Implements double dabble algorithm
- Spartan-3 compatible (no division/modulus for non-power-of-2 values)
- Handles values up to 511 (9 bits)

### 2. sevenseg_data_driver.v

Converts 4-bit BCD data to 7-segment display patterns.

**Ports:**
- `input [3:0] data` - 4-bit BCD input
- `output reg [7:0] pinout` - 7-segment output pattern (including decimal point)

**Display Patterns:**
- `0` → `00111111`
- `1` → `00000110`
- `2` → `01011011`
- `3` → `01001111`
- `4` → `01100110`
- `5` → `01101101`
- `6` → `01111101`
- `7` → `00000111`
- `8` → `01111111`
- `9` → `01101111`

### 3. sevenseg_sel.v

Multiplexes time data across multiple 7-segment displays with scanning.

**Ports:**
- `input clk` - System clock
- `input reset` - Reset signal
- `input [8:0] houres` - 9-bit hours input (0-23/12)
- `input [5:0] minute` - 6-bit minutes input (0-59)
- `output reg [4:0] sel` - Display selection output
- `output reg [3:0] data` - Multiplexed data output

**Features:**
- Uses binary_to_bcd for conversion
- Implements display scanning with counter-based timing
- Cycles through four displays: minutes ones, hours ones, hours tens, minutes tens
- Reset functionality for display initialization

### 4. main.v

Top-level module that integrates the complete system.

**Ports:**
- `input clk` - System clock
- `input reset` - Reset signal
- `input [8:0] houres` - Hours input
- `input [5:0] minute` - Minutes input
- `output [4:0] seg_sel` - Segment selection lines
- `output [7:0] seg_data` - Segment data lines

## Usage Example

```verilog
// Instantiate the main module
main digital_clock (
    .clk(sys_clk),
    .reset(sys_reset),
    .houres(9'd14),    // 14 hours
    .minute(6'd35),    // 35 minutes
    .seg_sel(display_select),
    .seg_data(segment_data)
);
```

## Key Features

- **FPGA Compatibility**: Designed specifically for Spartan-3 FPGAs with limited arithmetic capabilities
- **Efficient Conversion**: Uses shift-and-add algorithm instead of division/modulus
- **Display Scanning**: Multiplexes displays to reduce pin count
- **Reset Support**: Proper initialization and reset handling
- **Flexible Input**: Supports various time formats (12/24 hour)

## Clock Requirements

The system requires:
- Main clock for the display scanning logic
- The counter in `sevenseg_sel.v` divides the clock by 80,000 for display refresh
- Adjust the counter value based on your clock frequency for proper refresh rates

## Reset Behavior

When reset is asserted:
- Display selector defaults to position 4 (5'b01000)
- Display shows '7' as initial value
- Normal operation resumes after reset release

## Display Format

The displays show time in the format: **HH:MM**
- Display 1: Minutes ones digit
- Display 2: Hours ones digit  
- Display 3: Hours tens digit
- Display 4: Minutes tens digit

## Limitations

- Supports maximum 9-bit hours (0-511) and 6-bit minutes (0-63)
- Designed for common anode 7-segment displays (pattern may need inversion for common cathode)
- Refresh rate depends on system clock frequency

## Dependencies

- All modules are self-contained with no external dependencies
- `sevenseg_sel.v` includes `binary_to_bcd.v`
- `main.v` includes both `sevenseg_sel.v` and `sevenseg_data_driver.v`

for using in other modules use include sevenseg_sel.v and include sevenseg_data_driver.v in your topmodule 

## Author

Mahan F. Pourkami  
Date: 28/08/2025

This project demonstrates efficient digital clock implementation on resource-constrained FPGA platforms using Verilog HDL.
