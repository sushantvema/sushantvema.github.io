# Signed and Unsigned Numbers
Reference: 2.4, Computer Organization and Design RISC-V Edition

123 base 10 = 1111011 base 2.

Numbers are kept in hardware as series of high and low electronic signals. Therefore they are considered base 2 numbers. 

Since all information is composed of binary digits of bits, a single digit of a binary number is the "atom" of computing. 

The value of the ith digit d is d * Base^i 

i starts at 0 and increases from right to left.

"Numbering the bits in a doubleword".

Least Significant Bit == rightmost bit. Most Significant bit leftmost bit.

The RISC-V doubleword is 64 bits long. We can represent 2^64 different 64-bit patterns.
Let those combinations represent the numbers from 0 to 2^64 - # 

These positive numbers are called unsigned numbers

## Hardware/Software Interface
Base 2 isn't natural to human beings. The first computer offered decimall arithmetic, but computer still used on and off signals. Decimal digit was represented by several binary digits. Decimal was so inefficient that later computers reverted to all binary.

If  a number that is the proper result of arithmetic operations cannot be represented by rightmost hardware bits, overflow is said to have occurred. It's up to the programming language, operating system, and program to determine what to do if overflow occurs.

We need a representation distinguishing the positive from the negative. Most obvious solution is to add a single bit for the sign. 

Sign and magnitude representation has several shortcomings. 
1. Not obvious where to put the sign bit.
2. Adders for sign and magnitude may need an extra step to set the sign because we can't know in advance what the proper sign will be.
3. Separate sign bit means that sign and magnitude has both positive AND negative zero which can lead to problems for inattentive programmers

If we tried to subtract a large number from a small, it would try to "borrow" from a string of leading 0s, so the result would have a string of leading 1s. 

Final solution was to pick the representation that made the hardware simple. Leading 0s mean positive and leading 1s mean negative.

This is called two's complement representation.

The positive half of the numbers from 0 to (2^63 - 1) uses same representation. Following bit pattern represents most negative number (1000.0000_2). This is -2^63. 

Every computer today uses two's complement binary representation for signed numbers. 

## Binary to Decimal Conversion
What is the decimal value of this 64-bit two's complement number?
Just substitute the number's bit values into the formula above.

Overflow occurs when leftmost retined bit of binary bit pattern is not the same as the infinite number of digits to the left (sign bit is incorrect). 

0 on the left of the bit pattern when number is negative or a 1 when number is positive.

## Signed versus unsigned loads

The function of a signed load is to copy the sign repeatedly to fill the rest of the register - called sign extension - but the PURPOSE is to place a correct representation of the number within that register.

Unsigned loads simply fill with 0s to the left of the data, since number represented by bit pattern is unsigned. 

RISC-V does offer two flavors of byte loads. load byte unsigned (`lbu`) treats the byte as an unsigned number and thus zero-extends to fill the leftmost bits of the register.

load byte (`lb`) works with signed integers. Since C programs almost always use bytes to represent characters rather than considering bytes as very short signed integers, lbu is used practically exclusively for byte loads.

## Memory Addresses
Unlike signed numbers, memory addresses naturally start at 0 and continue to the largest address. In other words, negative addresses make no sense.

Programs want to deal sometimes with numbers that can be positive or negative and sometimes with numbers that can be only positive.

Some languages reflect this distinction. C, for example, named the former as integers (declared as long long int) and the latter unsigned integers (unsigned long long int). Some C style guides even recommend declaring former as signed long long int to keep the distinction clear.

Here are two shortcuts when working with two's complement numbers. 

To negative a TC binary number, simple invert every 0 to 1 and every 1 to 0 and add 1 to the result. The sum of a number and its inverted representation must be 111....111_two, which represents -1.

We use the notation x bar to mean invert every bit in x from 0 to 1 and vice versa.

To convert a binary number represented in n bits to a number represented with more than n bits, take the most significant bit from the smaller quantity (the sign bit) and replicate it to fill the new bits of the larger quantity.

Old nonsign bits are copied into right portion of the new doubleword. This is commonly called sign extension.

The unanimous choice since 1865 has been two's complement.

For signed decimal numbers, we used "-" to represent negative because there are no limits to the size of a decimal number. 

Given a fixed data size, binary and hexademical bit strings can encode the sign. Therefore we do not normally use + or _ with binary or hexademical notation.

Just replace one hexademical digit by the corresponding four binary digits, and vice versa. If length of the binary number is not a multiple of 4, go from right to left.

Third alternative representation to two's complement and sign and magnitude is called one's complement. Negative of a one's complement is found by inverting each bit from 0 to 1 and from to 0. This relation helps explain its name since the complement of x is 2^n - x - 1. Similar to two's complement except that it also has two 0s. 

One's complement adders needed an extra step to subtract a number, hence two's complement dominates today. 

Biased notation: represents most negative value by 00...000_two and most positive value by 11...11_two with 0 typically having value 10...000_two

