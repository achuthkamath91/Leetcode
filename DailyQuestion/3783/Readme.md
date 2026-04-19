# Mirror Distance (LeetCode-style)

Problem: Given an integer `n`, define its mirror distance as `abs(n - reverse(n))`, where `reverse(n)` is the integer formed by reversing the decimal digits of `n` (leading zeros in the reversed number are dropped).

Return an integer denoting the mirror distance of `n`.

`abs(x)` denotes the absolute value of `x`.

---

## Examples

Example 1

Input:
```
n = 25
```
Output: `27`

Explanation:
```
reverse(25) = 52
abs(25 - 52) = 27
```

Example 2

Input:
```
n = 10
```
Output: `9`

Explanation:
```
reverse(10) = 01 -> 1
abs(10 - 1) = 9
```

Example 3

Input:
```
n = 7
```
Output: `0`

Explanation:
```
reverse(7) = 7
abs(7 - 7) = 0
```

---

## Constraints

- `1 <= n <= 10^9`

---

## Approach

To compute `reverse(n)` you can either:

- Convert `n` to a string, reverse it, and parse back to an integer (easy and clear), or
- Reverse the digits numerically using arithmetic to avoid allocations: repeatedly take `n % 10`, append to a running `rev` value, and divide `n` by 10.

Then compute and return `abs(original_n - rev)`.

Pseudocode (numeric reverse):

```
orig = n
rev = 0
while n > 0:
    digit = n % 10
    rev = rev * 10 + digit
    n = n // 10
return abs(orig - rev)
```

This works correctly because leading zeros in the reversed number are naturally discarded by integer arithmetic.

---

## Complexity

- Time: O(d) where d is the number of digits in `n` (d = O(log10 n)).
- Space: O(1) extra space.

---
![img.png](img.png)
