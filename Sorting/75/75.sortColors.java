class Solution {
    //Dutch National Flag Algorithm
    public void sortColors(int[] nums) {
        int low = 0, mid = 0, high = nums.length - 1;
        while(mid <= high){
            if (nums[mid] == 0) {
                int tmp = nums[low];
                nums[low++] = nums[mid];
                nums[mid++] = tmp;
            }else if (nums[mid] == 1){
                mid++;
            }else{
                int tmp = nums[mid];
                nums[mid] = nums[high];
                nums[high--] = tmp;
            }
        }
    }

    // Counting color and iterate the array again to put the colors in right order
    public void sortColors(int[] nums) {
         int[] count = new int[3];
         for( int num: nums ){
             count[num]++;
         }
         int i=0;
         for( int j=0; j<3; j++){
             int color =  count[j];
             while(color>0){
                 nums[i] = j;
                 i++;
                 color--;
             }
         }
     }
 }