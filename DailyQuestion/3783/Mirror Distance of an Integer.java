class Solution {
    public int mirrorDistance(int n) {
        if( n <10 ) return 0;

        return Math.abs( n - reverseInt(n));
    }

    private int reverseInt(int n){
        int rev = 0;
        while(n >0){
            int digit = n % 10;
            n /= 10;
            rev = rev * 10 + digit;
        }
        return rev;
    }
}