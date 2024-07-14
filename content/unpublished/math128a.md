# Math W128a

## Matlab Introduction

Command window is most frequently used. All the course files are in the file browser to the left.

Calculator + advanced full feature programming language

Add a colon to hide output.

### Variables and Scripts

= is simple assignment

case sensitive. Can't start with _

Workspace on the right shows the entire namespace

Can create New File > Script. 

Can open file in the Editor window

Can time name of the file in the command window and it will run the file. 

Comments are with %

Can be in-line as well

### Functions

Function is something that has a name and performs some sort of computation. Built-in and user-defined functions.

Arrow up to page history

myfunc = @(x, y) + y^2

File syntax is slightly different

### For Loops

Pretty straightforward.

### Conditionals

== checks for equality
~= inequality

### Arrays

Can also use x = [1 2 3 4]

Also x = [1; 2; 3; 4]

length(x)

y ./ z is vectorized operation on an array

x = [1 2; 3 4] is a 2x2 matrix

Matlab is 1 indexed

### Plotting

Plotting causes popups. Can dock to main window

PDFs are the way to go for reports

## Chapter 1 Videos: Mathematical Preliminaries and Error Analysis

Description: Review of important results from calculus including Taylor's theorem which is used extensively. Introduce concept of round-off errors and discuss how computers approximate real numbers using so-called floating-point arithmetics. Characteristics of numerical algorithms like rate of convergence.

TOC:
- 1.1 Review of Calculus
- 1.2 Round-off Errors and Computer Arithmetic
- 1.3 Algorithms and Convergence

### 1.1: Limits

Limits are used to define integrals and derivatives as well as continuity.

The claim we want to make is that the lim(f(x)) as x -> x_0 = L. 

If we go up and down on the y-axis by epsilon, we want the delta that added to both sides of x_o, you're still within L. 

Continuous at x_0. Lim(f(x)) as x-> x_0 = f(x_0). There can't be any jumps

Limit can't exist because of jump. Therefore not continuous at x_0. 

#### Limits of Sequences

Limit is defined as m -> infinity. How to draw a sequence?
Need to have a value and an x-axis. Call it m. Y axis is X_m. 

Eventually start to converge in some capacity. Now we want to make a claim about the behavior of x as it goes to infinity. 

Choose an n large enough such that all the points above x +- epsilon is contained within bounds. 

Many cases where limits would not exist. Easy to come up with cases that they wouldn't work. 

Something like a sinusoidal function doesn't have a limit because you can't do the band things. 

If you come up with any sequence with a limit of x0, then the function of the sequence has a limit of f(x0).

### 1.1: Derivatives

Derivatives are defined using limits. 

A function f(x) is differentiable at a point x0 as the slope of the secant line between x0 and another point. Limit of this as x-> x0.

Limit doesn't have to exist. 

In order to solve differential equations, equations have to be written in the form of derivatives.

If it is differentiable, it is also continuous. 

Rolle's Theorem. If endpoints are equal values and function is continuous, there exists a point in the middle with derivative 0.

More general formulation is the Mean Value Theorem. Endpoints don't have to be equal. Secant line is equal to the derivative of some point. 

Extreme Value Theorem. Used for applications in optimization. Statement about maximizing and minimizing functions. Claims f(x) between a minimum and maximum. 

In order to find the maximum or minimum function, first look at endpoints. Maximum has to be either endpoints or function values where derivative equals 0. 

### 1.1: Integrals

First and simplest numerical method is Riemann Integral. Not taking the limit.

Integrate a function from a to b. Approximating signed area under the curve. Split up the integral in a finite number of integrals. Pick evenly spaced z sub i's and calculate f(z sub i) at each point. 

Sum those time's the delta. 

Weighted Mean Value Theorem for Integrals. Rectangle between a and b times a function value. Didn't quite understand the intuition of this.

Generalized Rolle's Theorem. Have a function that equals zero at some values. Bounds a and b. Obviously some values in the middle having to have 0 derivatives. 

There's a point somewhere where the nth derivative equal to zero (depending on how many middle points have zero derivatives between the zero values).

If 5 zeros in the function, at least 4 points where the derivative equals zero. 

Iteratively applying Rolle's theorem.

Intermediate Value Theorem. Continuity is all you need. If f in C[a, b] means continuity. If fx on a, b between f(a) and f(b), if function is continuous, there must be a value in the middle that is k. 

### 1.1: Taylor Polynomials

Given continuous and n-times differentiable: We form a taylor polynomial starting with the value + higher level derivatives etc. 

Sometimes Taylor Polynomial is called Maclaurin Polynomial. 

Taylor polynomials are used to approximate higher level functions. 

You'll get a bound on the error. The closer you get to x0 the better. 

Exercise. Find the max error in the following approximation. Take sinx and approximate with the following: x - x^3/3! + x^5/5!

When -0.3 <= x <= 0.3. To derive the error term, we need to compute some of the derivatives. 

f(x) = sinx
keep going until f^(4)(x) which is sinx.

The polynomial comes from evaluating all of these at 0. 

Now enough information to calculate the polynomial. The big question: What is n for the polynomial?

Use n = 6 for a tighter error bound. Very interesting example.

### 1.2: Floating Point Numbers

How does the computer store approximate real numbers?

Fixed point. Decimal is placed between 10^0 and 10^-1. 

In floating point, we insist on having the dot right after the first digit. Also signed. 

In a calculator this is called scientific notation. 

To represent a floating point number, we need:
- Sign
- Mantissa
- Exponent

format long command in matlab shows all 16 digits represented. Floating point notation. 

Consider 2/7. Or 1/3. 

1e308 is the limit of storage. 309 returns Inf. 

In linear algebra, 1000 * eye(3). Determinant results in weird stuff. This is called overflow.






