# DOOM on Blackboard

**Target**: Real Digital Blackboard (Zynq XC7Z007S), RV32IM soft core, VGA output

## Phase 0: Setup
The goal of this phase is to simply get necessary tools working together, which includes Vivado and the RISC-V GCC toolchain.
* Hello world: make an LED blink, and echo characters over the UART to prove the whole flow works (Verilog -> bitstream -> board).

## Phase 1: CPU Core

The CPU core will be based on the 32-bit RISC-V (RV32I + M) CPU in Verilog.

1. Learn RV32I ISA and datapath. Sketch the datapath first and ensure understanding of how components interact with each other before implementation.

2. Build the core and test it: start with a single-cycle or multi-cycle architecture (skip pipelining, pls LOL). Use hand-written assembly (Claude, help us) then the official `riscv-tests`, which check every instruction for us.

**Done when**: `RV32UI` test set passes in simulation.

3. Add multiply/divide and a timer: The M extension (RV32IM) makes C code much faster, and the board's DPS handles multiply cheaply. Add a memory-mapped timer (just a counter the CPU can read), so Doom can keep time.

4. Run C code in simulation: Write a small startup file and linker script, compile with `riscv32-unknown-elf-gcc -march=rv32im`, and convert the output into a memory-init file for our simulated RAM.

**Done when**: a C program runs correctly in simulation.

![5-stage core figure](\img\5-stage.png)

_[Figure 1: Basic overview of 32-bit five-stage RV32I RISC-V processor]_

**Completed when**: the CPU passes all official `riscv-tests` and C program (say, compute Fibonacci) runs correctly in simulation

## Phase 2: First real hardware

This phase includes the memory map, UART, and C on the board. Memory-mapped I/O means certain addresses talk to the hardware instead of RAM, such as writing bytes to address `0x1000_0000` and sending it out the UART. Put a boot ROM and small RAM in block RAM, add a UART, and print "hello" from C on the real board. 

**Completed when**: text from CPU appears in terminal.

## Phase 3: Graphics

The goal of this phase is to get a stable VGA image (no CPU needed) and our own C code draws pictures on the monitor.

---

**RV32IM Sources**
* [Official RV32IM Instruction Set](https://docs.riscv.org/reference/isa/v20260120/unpriv/rv32.html)
* [RV32IM, from gates up -- a walkthrough](https://arvaer.com/writing/softcore/)
* [Olivia Core! (Chandler designed)](https://github.com/chandyego84/olivia-core)
* [Computer Organization and Design ARM Edition' by David A. Patterson and John L. Hennessy (NOTE: Don't have to read the whole thing. There are more useful chapters like the 'Datapath' section.)](http://home.ustc.edu.cn/~louwenqi/reference_books_tools/Computer%20Organization%20and%20Design%20ARM%20edition.pdf)



