# 2833. Furthest Point From Origin

Difficulty: Easy

## Problem

You are given a string `moves` of length `n` consisting only of the characters `'L'`, `'R'`, and `'_'`. You start at position 0 on a number line. For each i-th move:
- If `moves[i] == 'L'` you must move one step to the left (position -= 1).
- If `moves[i] == 'R'` you must move one step to the right (position += 1).
- If `moves[i] == '_'` you may choose to move either left or right for that move.

Return the maximum possible distance from the origin (absolute position) that you can reach after performing all moves.

### Constraints
- 1 <= moves.length == n <= 50
- `moves` consists only of `'L'`, `'R'`, and `'_'`.

## Key idea / Approach

Count the number of fixed left moves `l`, fixed right moves `r`, and flexible moves `u` (the underscores). All flexible moves can be assigned to either left or right. To maximize the absolute distance from origin, assign every flexible move to whichever side already has the larger net count.

Let net = |r - l|. If you assign all `u` underscores to the side which increases the net displacement, the furthest distance is:

answer = net + u = |r - l| + u

This works because underscores can all be chosen to increase the difference between right and left counts; choosing them all in the same direction yields the maximum possible absolute displacement.

## Proof intuition

Suppose r >= l. The current displacement is (r - l). Assigning each underscore as `R` increases displacement by 1 each, so after using all underscores the displacement becomes (r - l + u). The absolute distance is the same for the opposite case (l > r) by symmetry.

Any splitting of underscores between left and right yields a smaller or equal absolute difference than assigning them all to the larger side.

## Time and Space Complexity
- Time: O(n) — single pass to count characters
- Space: O(1)

## Examples

1) Input: `moves = "L_RL__R"`

- Counts: L = 2, R = 2, _ = 3
- Answer: |2 - 2| + 3 = 3

Output: `3`

2) Input: `moves = "_R__LL_"`

- Counts: L = 2, R = 1, _ = 4
- Answer: |1 - 2| + 4 = 5

Output: `5`

3) Input: `moves = "_______"`

- Counts: L = 0, R = 0, _ = 7
- Answer: |0 - 0| + 7 = 7

Output: `7`

## Reference implementation (Java)

This small helper shows the described approach in Java. It is provided as a reference; you can adapt it to other languages.

```java
public class Solution {
    public int furthestDistanceFromOrigin(String moves) {
        int l = 0, r = 0, u = 0;
        for (char c : moves.toCharArray()) {
            if (c == 'L') l++;
            else if (c == 'R') r++;
            else u++; // underscore
        }
        return Math.abs(r - l) + u;
    }
}
```

## Notes
- The approach is optimal and trivial to implement for the given bounds.
- This README intentionally keeps only the problem, approach, examples, complexity, and a short reference implementation.

