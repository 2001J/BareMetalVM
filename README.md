# Bare Metal VM
A lightweight 16-bit virtual machine implementation with a basic instruction set architecture (ISA). This project demonstrates the fundamental concepts of virtual machines, 
including instruction execution, memory management, and error handling.
## Features
- 16-bit registers (AX, BX, CX, DX, SP, IP)
- 65KB memory space
- Basic instruction set: 
  - MOV(Move value to register)
  - NOP(No Operation)
  - HLT(Halt execution)
- Utility functions from `birchutils`.

## Architecture

### Registers

- General Purpose: AX, BX, CX, DX
- Special Purpose:
  - SP (Stack Pointer)
  - IP (Instruction Pointer)



### Memory Layout

- Single 65KB memory space (64K - 1 byte)
- Program loaded at beginning of memory
- Break line tracker to prevent overflow

Instruction Format
Instructions follow variable-length encoding:

```sh
Copymov ax,0x05  => 01 00 05  (3 bytes)
nop          => 02        (1 byte)
hlt          => 03        (1 byte)
```

### Implementation Details

- Error handling for memory allocation and segmentation faults
- Instruction mapping system for opcode sizes
- Virtual machine state management with CPU and memory
- Memory safety checks during execution

### Error Codes

- 0x00: No Error
- 0x01: System Halt
- 0x02: Memory Error
- 0x04: Segmentation Fault

## Prerequisites

- GCC (GNU Compiler Collection)
- Make
- Birchutils (see below for installation instructions)

## Installing `birchutils`

Before building the `BareMetalVM` project, you need to install the `birchutils` library. Follow these steps:

1. Download the `birchutils` library from the official website:
   [Download birchutils v1.3](https://repo.doctorbirch.com/birchutils/v1.3/)

2. Extract the downloaded archive and navigate to the `birchutils` directory:
   ```sh
   tar -xzf birchutils-v1.3.tar.gz
   cd birchutils
   ```

3. Modify the `Makefile` to include the `libdir`, `incdir`, and `install` target:
   ```makefile
   flags = -O3 -Wall -std=c2x
   ldflags = -fPIC -shared -ldl -D_GNU_SOURCE
   
   # Add these lines to specify the library and include directories
   libdir = /usr/local/lib
   incdir = /usr/local/include
   
   all: clean birchutils.so
   
   birchutils.so: birchutils.o
   cc $(flags) $^ -o $@ $(ldflags)
   
   birchutils.o: birchutils.c
   cc $(flags) -c $^
   
   clean:
   rm -f birchutils.o birchutils.so
   
   # Add this install target
   install: birchutils.so
   cp birchutils.so $(libdir)/libbu.so
   cp birchutils.h $(incdir)
   # For macOS
   install_name_tool -id $(libdir)/libbu.so $(libdir)/libbu.so
   # For Linux, you might need to run ldconfig instead
   # ldconfig
   ```
    - For Linux: The default values should work, but you may need to use ldconfig instead of install_name_tool.
    - For macOS: The provided Makefile should work as is.
    - For Windows: You may need to use a different build system (e.g., CMake) or adjust the paths accordingly.

4. Build and install the `birchutils`:
   ```sh
   make
   sudo make install
    ```

## Building the BareMetalVM Project

1. Clone the BareMetalVM repository:
   ```sh
   git clone https://github.com/2001J/BareMetalVM
   
   cd BareMetalVM
   ```

2. Build the project:
   ```sh
   make
   ```

## Running the BareMetalVM Program

To run the baremetal program, use the following command:
   ```sh
   ./baremetalvm
   ```

## License

This project is licensed under the Apache License.

## Acknowledgments

This project uses the `birchutils` library developed by [Doctor Birch](https://doctorbirch.com).

## Author

Joseph Paul Koyi
