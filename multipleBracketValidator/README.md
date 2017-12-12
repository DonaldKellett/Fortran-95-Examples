# [Valid Braces (`4 kyu`)](https://www.codewars.com/kata/valid-braces)

This is my first attempt at writing a slightly more complex program in Fortran 95.  This code exercise was directly taken from [Codewars](http://www.codewars.com) via the link I placed at the header of this `README` and translated directly into Fortran 95.

## Usage Examples

```fortran
validBrackets("") ! => .true.
validBrackets("abcde") ! => .true.
validBrackets("()[]") ! => .true.
validBrackets("))((") ! => .false.
validBrackets("{3 * [2 + (1.5 * x)]}") ! => .true.
validBrackets("(([{}{}{}{}{}][()({}{[]()()}{})()[][]{}[]()()()][{}{}]))") ! => .true.
validBrackets("([{)]}") ! => .false.
```

## **IMPORTANT NOTICE REGARDING CORRECTNESS OF PROGRAM**

It is not known whether this is due to a bug in the `gfortran` command-line Fortran 95 compiler or due to the `MutiplyBracketValidator` module itself (in this folder) relying on non-standard compiler-specific features, but **the** `validBrackets` **function in the** `MultiplyBracketValidator` **module behaves correctly for a wide variety of test cases on [JDoodle](https://www.jdoodle.com/execute-fortran-online) while going completely haywire locally on my computer when running the** `gfortran` **command, always returning** `.true.` **no matter what**.  Therefore, if you plan on using this function in your production code, take great care to test it against a large number of test cases **on your production compiler** to confirm that it is behaving correctly before pushing it to production.
