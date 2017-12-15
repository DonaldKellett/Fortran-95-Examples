# BFInterpreter

A module containing a standard Brainfuck interpreter in Fortran 95.

## Overview

Module `BFInterpreter` - the module containing the Brainfuck interpreter

<ul>
  <li>
    Function `brainfuck` - the standard Brainfuck interpreter
    <ul>
      <li>`code` - the Brainfuck code to be executed</li>
      <li>`input` - the input buffer passed to the Brainfuck program (as a string).  If there is no input (or the input is irrelevant to the Brainfuck program being executed), simply pass an empty string `""` instead</li>
    </ul>
  </li>
</ul>

## Implementation Details

This module uses a standard implementation of Brainfuck whose features are highlighted below:

1. The memory tape consists of exactly `30000` wrapping 8-bit cells and is *not* cylindrical (i.e. pointer does not return to one end of the memory tape after going past the other end).
2. The memory pointer starts from the leftmost cell of the memory tape.
3. The end-of-input / end-of-file (EOF) is denoted as `byte(0)` and is read into the cell under the memory pointer as such every time a byte of input is requested from the program when the input stream is already exhausted.
4. As per the official Brainfuck specification, any non-command characters (i.e. those other than `,.+-<>[]`) are simply ignored and can serve as comments.  "Traditional" hacks (e.g. `#`, `!`) are **not** enabled.

Note that this is a **dumb**/**naïve** implementation - it is **not** optimized in *any* manner with regards to performance, nor was it intended to be optimized in any way in the first place.  Therefore, this interpreter is **not** recommended for use in production environments where performance is critical.

### Error Handling

This implementation does **not** include any error handling - it assumes that every program passed in is valid.  Invalid programs such as those containing syntax errors (i.e. unmatched square brackets) or those causing the memory pointer to go out of bounds will yield **undefined** behavior (most likely a segfault).  Programs containing infinite loops would of course fail to terminate as one would expect.

## Guarantee of correctness of program

This program has been tested against various Hello World programs (both with and without comments), a simple CAT program and a rather complex Fibonacci program using a GNU Fortran compiler and passed all tests.  If you discover a bug in the interpreter, feel free to raise an Issue Report on this Repo.

## Example Usage

```fortran
brainfuck(",[.,]", "Fortran 95") ! => "Fortran 95"
```
