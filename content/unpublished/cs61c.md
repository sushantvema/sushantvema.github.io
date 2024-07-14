# CS 61c

[[cs61c-grading-tracker]]

## Lecture 02: Number Representation

Data input: Analog -> Digital. Two things to convert between analog and digital data:
1. Sample
  - E.g measure amplitude every so often, periodically
2. Quantize
  - For every one of these samples, we figure out where, on a 16-bit "yardstick" it lies

Digital data is not necessarily born Analog. 

**Big IDEA: Bits can represent anything!**

Characters?
- 26 letters -> 5 bits
- upper/lower case + punctuation -> 7 bits (in 8) (ASCII)
- Standard code to cover all the world's languages -> 8,16,32 bits ("Unicode")

Logical values (boolean)

Colors, hexcode. Locations? Addresses? Commands?

Number of categories -> log base 2 -> ceiling.

### Binary, Decimal, Hex

Base 10 (Decimal). 

Base 2. Binary. "0b1101". 

Base 16. Hexadecimal. 
Digits: 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, A, B, C, D, E, F=15. 
Can ask "A5" in hex? or 0xA5. 

Convert from decimal to binary.
1. 13 to binary?
  - Start with the columns. Think of the boxes analogy. 

Binary -> Hex. **Always left-pad with 0s to make full 4-bit values, then look up!**

0b11110 to hex -> 0b00011110. Then look up 0x1E

Hex -> Binary, just look it up digit by digit.

4 bits is a "nibble". 1 hex digit is 16 things. 

8 bits is a "byte". 2 hex digits = 256 things.

In the history of computer graphics, scientists figured out that you only need 8 bits for colors. 

For example, #D0367F = some shade of pink

Decimal is great for humans especially when doing arithmetic.

If humans are looking at long strings of binary numbers, it's easier to convert to hex and see 4 bits/symbol.

Binary is what computers use. You will learn how computers do +, -, *, /. 

```c
#include <stdio.h›

int main () {
  const int N = 1234;
  printf ("Decimal: &d\n", N);
  printf ("Hex: %x\n", N) :
  printf("Octal: &0\n", N);

  printf("Literals (not supported by all compilers):\n");
  printf("0x4d2=&d (hex) \n", 0x4d2);
  printf ("0b10011010010 = %d (binary) \n", 0b10011010010);
  printf ("02322 = %d (octal, prefix 0 - zero) \n", 02322);
｝
```

### Number Representation

What to do with number representations? Add, subtract, multiply, divide, compare. 

What is they're too big? Binary bit patterns are simply representatives of numbers. Abstraction! Strictly speaking, they are called "numerals".

Numerals really have an infinite number of digits. With almost all being the same except for a few of the rightmost digits. Just don't normally show leading digits. 

If the result of add (or sub, mult, div) cannot be represented by rightmost bits, we save overflow occurred. For unsigned integers, overflow occurs both ways.

How to represent negative numbers? C18's type is uintN_t. So far, unsigned numbers. 

The obvious solution is the define the leftmost bit to be the sign. "Ain't no free lunch" story.

Unsigned numbers are like a binary odometer. 

Shortcomings of sign and magnitude. 
- Arithmetic circuit complicated. Special steps depending on if signs are same or not
- Also, two zeros. 

Another try: complement the bits
- Example: 7_10 = 00111_2. -7_10 = 11000_2
- This is called One's Complement
- One's complement was eventually abandoned because there was a better system.

### Two's Complement and Biased Encoding

Problem is that the negative mappings overlap with the positive ones since two zeros. Want to shift the negative mappings left by one. For negative numbers, complement, then add 1 to the result. 
- As with sign and magnitude, and & one's complement. Leading 0's -> positive, leading 1s -> negative
- 00000...xxx >= 0, 11111...xxx < 0. 
- This representation is Two's Complement. This makes the hardware simple
- C's int, C18's intN_t, aka a "signed integer"

Two's Complement Formula
- Can represent positive and negative numbers in terms of the bit value times a power of 2
- d_31 * -(2^31) + d_30 * 2^30 + ... + d_2 * 2^2 + d_1 * 2^1 + d_0 * 2^0
- Example: 1101_two in a nibble?

Bias Encoding: N=5, (bias=-15)
- Number = unsigned + bias
- Bias for N bits chosen as -(2^N-1 - 1)
- One zero
- How many positives?

This makes the smallest number 000000. 

In Summary:
- We represent things in computers as particular bit patterns. N bits -> 2^n things
- These 5 integer encodings have different benefits. 1's complement and sign/mag have most problems
- Unsigned (C18's uintN_t) starts from 0
- For biased encodings we have to communicate to the receiver what the bias will be.
- Overflow: numbers infinite, computers finite. Errors!

## Lecture 03: Introduction to the C Programming Language

Computer Organization:

ENIAC (U Penn, 1946)
- First general purpose computer
- Blazingly fast. Multiply in 2.8 ms. 10 decimal digits * 10 decimal digits
- Needed 2-3 days to steup new program
- Programmed with patch cords and switches
  - At that time, "computer" mostly referred to people that did the calculations

EDSAC (Cambridge, 1949)
- First general stored-program computer
- Programs held as numbers in memory
  - This is the revolution. It isn't just programmable, but the program is jsut the same type of data that the computer computes on
  - Bits are not just the numbers being manipulated, but the instructions on how to manipulate the numbers
- 35 bit numbers

Introduction to C
- Kernighan and Ritchie. C is not a very high level language, not a big one. Not specialized to any particular area of application. Its absence of restrictions and its generality make it more convenient and effective for many tasks than supposefly more powerful languages.
- Enabled first operative system not written in assembly language. UNIX - A portable OS! You can write the code and then take it to a different architecture. 

Why C?
- We can write programs that allow us to exploit underlying features of the architecture. 
  - Memory management, special instructions, parallelism

C and derivatives (C++, Obj-C, C#) still one of the most popular programming languages after >40 years

If you are starting a new project where performance matters use either Go or Rust
- Rust, "C-but-safe": By the time your C is (theoretically) correct with all necessary checks it should be no faster than Rust
- Go, "Concurrency": Practical concurrent programming to take advantage of modern multi-core microprocessors

Disclaimer:
- You will not learn how to fully code in C in these lectures. You'll still need your C reference
- K&R is a must-have
- Useful reference: JAVA in a Nutshell, O'Reilly
  - Chapter 2, "How Java Differs from C"
- Brian Harvey's helpful transition notes
  - HarveyNotesC1-3.pdf

Key C concepts: Pointers, Arrays, Implications for Memory Management
- Key security concept: All of the above are unsafe: If your program contains an error in these areas it might crash immediately but instead leave the program in an inconsistent (and often exploitable) state. 

### Compile versus Interpret


C compilers map C programs directly into architecture-specific machine code (string of 1s and 0s). 
- Unlike Java, which converts to architecture-independent bytecode that may then be compiled by a just-in-time compiler (JIT)
- Unlike Python environments, which converts to a byte code at runtime
  - These differ mainly in exactly when your program is converted to low-level machine instructions ("levels of interpretation").

For C, generally a two part process of compiling .c files to .o files, then linking the .o files into executables
- Assembling is done, but it is hidden

The benefit of make and C in general is that we only need to compile changed files. Don't need to always re-compile everything.

Compilation: Advantages
- Reasonable compilation time: enhancements in compilation procedure (Makefiles) allow only modified files to be recompiled
- Excellent run-time performance: generally much faster than Scheme or Java for comparable code (because it optimizes for a given architecture)
  - These days a lot of performance is in libraries
  - Plenty of people do scientific computation in Python
    - Good libraries for accessing GPU-specific resources
    - Also, many times python allows the ability to drive many other machines very easily. See the Spark lecture
    - Python can call low-level C code to do work: Cython

Reasonable reason to segment code into different files is that it is MUCH better for compilation. 

Compilation: Disadvantages
- Compiled files, including the executable, are architecture-specific, depending on processor type (e.g MIPS vs x86 vs RISC-V) and the operating system (e.g Windows vs Linux vs MacOS)
- Executable must be rebuilt on each new system
  - Porting code to new architecture
- Change 0> Compile -> Run repeat iteration cycle can be slow during development
  - but make only rebuilds changed pieces and can compile in parallel: make -j
  - linker is sequential though -> Amdahl's Law

C Pre-Processor (CPP)
- foo.c -> CPP -> foo.i -> Compiler
- C source files first pass through macro processor, CPP, before compiler sees code
- CPP replaces comments with a single space
- CPP commands begin with '#'
  - #include "file.h" /* Inserts file.h into output */
  - Check slides for this
- Use -save-temps to check CPP intermediate outputs


CPP Macros: A Warning
- You often see CPP macros defined to create small "functions"
  - But they aren't actual functions, instead it just changes the text of the program
  - In fact, all #define does is string replacement
  - #define min(X,Y) 
This can produce interesting errors with macros if foo(z) has a side-effect.

Not sure I understand this thing about macros.

### C vs Java

- Type of language: Function oriented, vs object oriented
- Programming Unit: Function vs abstract data type
- Compilation: gcc hello.c creates machine language code vs javac Hello.java creats java virtual machine language bytecode
- Execution: a.out loads and executes program vs java Hello interprets bytecodes
- hello, world
- Storage: Manual (malloc, free) vs New allocates & initializes, Automatic (garbage collection) frees
- Comments (C99 same as Java): same comments
- Constants: #define, const vs final
- Preprocessor: Yes vs no
- Variable declaration: Beginning of block vs before
- Variable naming conventions: sum_of_squares vs sumOfSquares
- Accessing a library: #include <stdio.h> vs import java.io.File;

C vs Java... operators nearly identical
- arithmetic
- assignment
- augmented assignment
- bitwise logic
- bitwise shifts
- boolean logic
- equality testing
- subexpression grouping
- order relations
- increment and decrement
- member selection

Has there been an update to ANSI C?
- Yes. It's called the C99 or C9x std
  - to be safe: gcc -std=c99 to compile
  - prinf("&ld\n", __STDC_VERSION__); 199901
- Reference on wikipedia
- Highlights
  - Declarations in for loops like Java
  - Java-like // comments
  - Variable-length non-global arrays
  - <inttypes.h> explicit integer types
  - <stdbool.h> for boolean logic definitions

Has there been an update to C99?
- Yes. Called C11 (C18 fixes bugs)
Highlights
- Multi-threading support
- Unicode strings and constants
- Removal of gets()
- Type-generic Macros (dispatch based on type)
- Support for complex values
- Static assertions, Exclusiv create-and-open, ...

C Syntax: main
- To get the main function to accept arguments, use this:
  - int main (int argc, char *argv[])
- What does this mean?
  - argc will contrain the number of strings on the command line (executable counts as one, plus one for each argument). Here argc is 2
    - unix& sort myFile
  - argv is a pointer to an array containing 

### C Syntax

What evaluates to FALSE in C?
- 0
- NULL
- Boolean types provided by C99's stdbool.h

What evaluates to TRUE in C?
- Everything else
- Same idea as in Scheme
  - Only #f is false, everything else is true

Typed Variables in C
- Must declare the type of data a variable will hold
  - Types can't change. E.g, int var = 2;

Integers: Python vs Java vs C
- C: int should be integer type that targets processer works with most efficiently
- Only guarantee
  - sizeof(long long) >= sizeof(long) >= sizeof(int) >= sizeof(short)
- Also, short >= 16 bits, long >= 32 bits
- All could be 64 bits
- This is why we encourage you to use intN_t and uintN_t. This is highly recommended to create clean code


Consts and Enums in C
- Constant is assigned a typed value once in the declaration; value can't change during entire execution of program
  - You can have constant version of any of the standard C variable types
- Enums: a group of related integer constants
  - enum color {RED, GREEN, BLUE}

Typed Functions in C
- You have to declare the type of data you plan to return from a function
- Return type can be any C variable type, and is placed to the left of the function name
- You can also specify the return type as void
  - Just think of this as saying that no value will be returned
- Variables anf cuntions MUST be declared before they are used

Structs in C
- Typedef allows you to define new types
- Structs are structured groups of variables e.g

C Syntax: Control Flow
- Within a function, remarkably close to Java constructs for control flow
- if-else. Always put brackets around if
- for
- switch
  - have to put a break after each statement
- C also has goto
  - Can result in spectacularly bad code if you use it, so don't

First Big C Program: Compute Sines table
- ANSI style is to declare variables at the beginning of the function
- C has one shared namespace
- While loops should check on integer values not floating point values

## Lecture 04: Pointers, Arrays, Strings

### Bugs and Pointers

C Syntax: Variable Declarations
- Similar to Java, but with a few minor but important differences
  - All variables declarations must appear before they are used
  - All must be at the beginning of a block
  - A variable may be initialized in its declaration; if not, it's garbage

Undefined Behavior
- Unpredictable behavior
- Often characterized as "Heisenbugs". Repeatable bugs are called "Bohrbugs"

Address vs Value.
- Consider memory to be a single huge array. Each cell has an address associated with it. Each cell also stores some value. Do they use signed or unsigned numbers? Negative address?

Don't confuse the address referring to a memory location with the value stored in that location.

For now, abstraction lets us think we have access to infinite memory, numbered from 0.

Pointers. 
A variable that contains the address of a valuable. 
Array, address, pointer, value. 

Pointer Syntax:
int *p; Tells compiler that variable p is address of an int. 

p = &y; Tells compiler to assign address of y to to p. Called the address operator in this context. 

z = *p; Tells compiler to assign value at address in p to z. Called dereference operator. 

How to change a variable pointed to? Use star on the left. 

Java and C pass parameters "by value". Procedure/function/method gets a copy of the parameter, so changing the copy cannot change the original. 

How to get a function to change a value?

```c
void addOne (int *p) {
  *p = *p + 1;
}
int y = 3

  addOne(&y);
```

More C Pointer Dangers:

Declaring a pointer just allocates space to hold the pointer. It does not allocate something to be pointed to!
Local variables in C are not initialized, they may contain anything. 

Pointers in C... The Good, Bad, and the Ugly:

Why use pointers? If we want to pass a large struct or array, it's easier/faster/etc to pass a pointer than the whole thing. Otherwise we'd need to copy a huge amount of data. In general, pointers allow clearner, more compact code.

What are the drawbacks? Pointers are probably the single largest source of bugs in C, be careful anytime you deal with them. Most problematic with dynamic memory management. Coming up next time. Dangling references and memory leaks. 

### Using Pointers Effectively

Pointers are used to point to any data type. int, char, a struct, etc. 

Normally a pointer can only point to one type. int char, struct, etc. Void * is a type that can point to anything. Use sparingly to help avoid program bugs and security issues. 

You can even have pointers to functions. 

Structures.

```c
typedef struct {
  int x;
  int y;
} Point;

Point p1;
Point p2; 
Point *paddr;
```

Dot and arrow notation. Most people use arrow notation. If you use p1 = p2; that signified a copy. 

NULL pointers:

The point of all 0s is special. If you write to or read a null pointer, your program should crash. SInce 0 is false, it's very easy to do tests for null. 

Pointing to Different Size Objects:

Modern machines are byte-addressable. Hardware's memory composed of 8-bit storage cells, each has a unique address.
C pointer is just abstracted memory address.
Type declaration tells compiler how many bytes to fetch on each access through pointer. 
We actually want word alignment. Some processors won't allow you to address 32 byte values without being on 4 byte boundaries. Others will be very slow if you try to access unaligned memory. 

sizeof() operator:

Returns number of bytes in object. Includes padding needed for alignment.
By C99 definition, sizeof(char)==1. 
Can take sizeof(org) or sizeof(structtype)
Will see more of sizeof when we look at dynamic memory management. 

### Arrays

Declaration. int ar[2]; Declared a 2-element integer array. Really just a block of memory. 

Can declare and initialize in the same time. Declares and fills a 2-elt integer array.

Arrays are almost identical to pointers. char *string and char string[] are nearly identical declarations. Differ in very subtle ways. incrementing, declaration of filled arrays.

Array variable is a pointer to the first element. 

ar is an array variable but looks like a pointer in maney respects. ar[0] is the same as *ar. ar[2] is the same as *(ar+2). Use pointer arithmetic to access arrays more conveniently. 

Declared arrays are only allocated while the scope is valid. 

Array size n. Want to access from 0 to n-1. You use should use counter and utilize a variable for declaration and incr.

The single source of truth is a valuable thing. 

Pitfall: An array in C does not know its own length and bounds not checked! Consequently, we can accidentally access off the end of an array. We must pass the array and its size to a procedure which is going to traverse it. 

Segmentation faults and bus errors. These are VERY difficult to find. Will learn how to debug these in lab. 

Pointer Arithmetic:

Pointer + n. Adds n*sizeof(whatever pointer is pointing to) to the memory address. 

Idea. Pass a pointer to a pointer! Declared as **h. 

map (actually mutate_map easier)

## Lecture 05: C Memory Management

Dynamic Memory Allocation:

To allocate room for something new to point to, use malloc (). With the help of typecast and sizeof. 

ptr = (int *) malloc (sizeof(int));

ptr points to a space somewhere in memory of size (sizeof()int) in bytes. 
(int *) simply tells the compiler what will go into that space (called a typecast).

malloc is almost never used for 1 var. 

Once malloc() is called, the memory location contains garbage, so don't use until you've set its value. After dynamically allocating space, we must dynamically free it. 
free(ptr)

Use this command to clean up. Even though the program frees all memory on exit or when main returns, don't be lazy. 

You never know when your main will get transformed into a subroutine. 

free()ing the same piece of memory twice will cause error. calling free() on something you didn't get from malloc(). 

Managing the Heap: realloc(p, size):

Resize a previously allocated block at p to a new size. If p is NULL, then realloc behaves like malloc. If size is 0, then realloc behaves like free. deallocating the block from the heap. 

Returns new address of the memory block. Note: it is likely to have moved. 

Arrays are not implemented as you'd think.

### Linked List Example

Don't forget the globals:

What is stored? Structure declaration does not allocate memory. Variable declaration does allocate memory.

So far we have talked about several different ways to allocate memory for data. Declaration of a local variable. 

Or dynamic allocation at runtime by calling allocation function. 

One more possibility. Data declared outside of any procedure. Similar to above point but has global scope. 

C has 3 pools of memory. Static storage: global variable storage, basically permanent, entire program run. The Stack: local variable storage, parameters, return address (location of activation records in Java or stack frame in C). The Heap: dynamic malloc storage: data lives until deallocated by program. 

Heap is not the same as the heap data structure. 

Normal C Memory Management:

A program's address space contains 4 regions. 
Stack: local variables, grows downward,
heap: space requested for pointers via malloc(); resizes dynamically, grows upward.
static data: variables declared outside main, doesn't grow or shrink. 
code: loaded when program starts, doesn't change. 

Where are variables allocated?
If declared outside a procedure (global), allocated in static storage

The Stack:
Stack frame includes return address, parameters, space for other local variables. 

Stack frames contiguous blocks of memory. Stack pointer tells where top stack frame is. 

### Memory Locations

Don't forget the globals.

What is stored?
- Structure declaration DOES NOT allocate memory.
- Variable declaration does allocate memory

DIffferent ways to 

## Lab 1: C

Designed to familiarize me with basic C concepts and prepare for project 1. 




