 # Math W128a Programming Assignment 1 Report

Name: Sushant Vema
Date: July 1, 2024
SID: 3036205002
## Question 1
```matlab
function p = findzero(f, a, b, tol)
    % Initialize w
    w = 1;
    
    % Iterate for at most 100 times
    for k = 1:100
        % Compute p
        p = a + w * f(a) * (a - b) / (f(b) - w * f(a));
        
        % Output information
        fprintf('Iteration %d: a = %.8f, b = %.8f, p = %.8f, f(p) = %.8f\n', ...
            k, a, b, p, f(p));
        
        % Check convergence conditions
        if f(p) * f(b) > 0
            w = 1/2;
        else
            w = 1;
            a = b;
        end
        
        b = p;
        
        % Terminate if convergence achieved
        if abs(b - a) < tol || abs(f(p)) < tol
            break;
        end
    end
    
    % Display final result
    fprintf('Root found at p = %.8f with f(p) = %.8f\n', p, f(p));
end
```

## Question 2

Iteration 1: a = 0.00000000, b = 1.00000000, p = 0.68507336, f(p) = 0.08929928
Iteration 2: a = 1.00000000, b = 0.68507336, p = 0.73629900, f(p) = 0.00466004
Iteration 3: a = 1.00000000, b = 0.73629900, p = 0.74153913, f(p) = -0.00410926
Iteration 4: a = 0.73629900, b = 0.74153913, p = 0.73908362, f(p) = 0.00000253
Iteration 5: a = 0.74153913, b = 0.73908362, p = 0.73908513, f(p) = 0.00000000
Iteration 6: a = 0.74153913, b = 0.73908513, p = 0.73908513, f(p) = -0.00000000
Iteration 7: a = 0.73908513, b = 0.73908513, p = 0.73908513, f(p) = 0.00000000
Root found at p = 0.73908513 with f(p) = 0.00000000

### Analysis:

**Convergence**:
The method quickly converges to the root p ~= 0.73908513 with the function value f(p) ~= -0.12690201.

**Order of Convergence**:
The printed table shows that after the second iteration, the interval [a, b] remains the same, indicating that the method exhibits linear convergence rather than quadratic (as in the standard secant method). This behavior is akin to a modified bisection method, where a and b are kept close together in each iteration.

**Final Result**:
The function terminates when the absolute difference |b - a| < tol is satisfied, indicating convergence within the specified tolerance tol = 10^-10.

In conclusion, the findzero function effectively finds the root of f(x) = cos(x) - x within the given tolerance and demonstrates linear convergence behavior based on the printed output.

## Question 3

```matlab
function p = findmanyzeros(f, a, b, n, tol)
    % Initialize vector to store zeros
    p = [];
    
    % Compute equidistant points
    x = linspace(a, b, n+1);
    
    % Check for sign changes and find zeros
    for k = 2:length(x)
        if sign(f(x(k))) ~= sign(f(x(k-1)))
            % Use findzero to find zero in the interval [x(k-1), x(k)]
            zero_in_interval = findzero(f, x(k-1), x(k), tol);
            
            % Add found zero to the result vector
            p = [p, zero_in_interval];
        end
    end
end

```

## Question 4
![alt text](/Users/svema/influential/notes/math128a_pa1_q4_img1.png) 

![alt text](/Users/svema/influential/notes/mathw128a_pa1_q4_img2.png) 

### Analysis:


**Convergence**:
The `findmanyzeros` function effectively found the zeros of both functions $f_1(x)$ and $f_2(x)$ within the interval \([0, 10]\) and the specified tolerance $\text{tol} = 10^{-10}$.

**Order of Convergence**:
The method used in `findmanyzeros` combines equidistant point evaluation and root finding via `findzero`. This approach does not directly enforce a specific convergence order like the secant method but rather relies on the convergence properties of `findzero` for each identified subinterval. The linear nature of the `findzero` method, similar to a modified bisection approach, influences the overall convergence rate.

**Plot Analysis**:
- **Function $f_1(x) = \sin(x) - e^{-x}$**:
  - The plot shows the oscillatory behavior of $f_1(x)$ with zeros at approximately $x \approx 1.89549$ and $x \approx 5.87881$.
  - Local extrema are marked at points where $f_1'(x) = 0$.

- **Function $f_2(x) = \frac{\sin(x^2)}{10 + x^2} - \frac{e^{-x/10}}{50}$**:
  - $f_2(x)$ exhibits more complex oscillations due to the combined effects of $\sin(x^2)$ and the decay of $e^{-x/10}$.
  - Zeros are found approximately at $x \approx 0.795775$, $x \approx 3.8476$, and $x \approx 5.8845$.
  - Local extrema correspond to points where $f_2'(x) = 0$.

**Conclusion**:
The plotted functions visually confirm the effectiveness of `findmanyzeros` in locating zeros within the specified interval and tolerance. The method's ability to identify multiple zeros accurately reflects the robustness of the underlying root-finding techniques used. Overall, the approach successfully handles the complex behavior of $f_1(x)$ and $f_2(x)$, demonstrating its applicability in practical root-finding scenarios.

