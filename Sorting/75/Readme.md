# LeetCode 75 — Sort Colors

Problem: Given an array `nums` with n objects colored red, white, or blue, sort them in-place so that objects of the same color are adjacent, with the colors in the order red, white, and blue.

We will use the integers `0`, `1`, and `2` to represent the color red, white, and blue, respectively.

You must solve this problem without using the library's sort function.

---

## Examples

Example 1

Input:
```
nums = [2, 0, 2, 1, 1, 0]
```
Output:
```
[0, 0, 1, 1, 2, 2]
```

Example 2

Input:
```
nums = [2, 0, 1]
```
Output:
```
[0, 1, 2]
```

---

## Constraints

- `n == nums.length`
- `1 <= n <= 300`
- `nums[i]` is either `0`, `1`, or `2`.

---

## Approach

**Dutch National Flag Algorithm (Three-pointer / One-pass)**

Since we only have three distinct values (0, 1, 2), we can partition the array in a single pass using three pointers:

- `left` pointer: tracks the boundary where 0s should end (starts at 0)
- `mid` pointer: current element being examined (starts at 0)
- `right` pointer: tracks the boundary where 2s should start (starts at end)

Algorithm:
- Iterate with `mid` from left to right:
  - If `nums[mid] == 0`: swap with `nums[left]`, increment both `left` and `mid`
  - If `nums[mid] == 1`: increment `mid` (already in correct region)
  - If `nums[mid] == 2`: swap with `nums[right]`, decrement `right` (do not increment `mid` yet, as we need to check the swapped value)

This ensures:
- All 0s are placed before index `left`
- All 2s are placed after index `right`
- All 1s are in the middle

Pseudocode:

```
left = 0, mid = 0, right = n - 1
while mid <= right:
    if nums[mid] == 0:
        swap(nums[mid], nums[left])
        left += 1
        mid += 1
    elif nums[mid] == 1:
        mid += 1
    else:  // nums[mid] == 2
        swap(nums[mid], nums[right])
        right -= 1
```

---

## Complexity

- Time: O(n) — single pass through the array
- Space: O(1) — only a few pointers used, sorting in-place

---

## Follow-up

The above approach is a one-pass algorithm using only constant extra space, which solves the follow-up question.

---

## Notes

- This is a classic application of the Dutch National Flag problem (attributed to Edsger W. Dijkstra).
![img.png](img.png)