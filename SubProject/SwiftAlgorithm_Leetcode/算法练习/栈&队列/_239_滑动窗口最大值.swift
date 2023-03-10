//
//  _239_滑动窗口最大值.swift
//  算法练习
//
//  Created by 沙睿 on 2022/5/30.
//

import Foundation
/**给你一个整数数组 nums，有一个大小为 k 的滑动窗口从数组的最左侧移动到数组的最右侧。你只可以看到在滑动窗口内的 k 个数字。滑动窗口每次只向右移动一位。
返回 滑动窗口中的最大值 。
示例 1：

输入：nums = [1,3,-1,-3,5,3,6,7], k = 3
输出：[3,3,5,5,6,7]
解释：
滑动窗口的位置                最大值
---------------               -----
[1  3  -1] -3  5  3  6  7       3
 1 [3  -1  -3] 5  3  6  7       3
 1  3 [-1  -3  5] 3  6  7       5
 1  3  -1 [-3  5  3] 6  7       5
 1  3  -1  -3 [5  3  6] 7       6
 1  3  -1  -3  5 [3  6  7]      7

来源：力扣（LeetCode）
链接：https://leetcode.cn/problems/sliding-window-maximum
著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */
class _239_滑动窗口最大值 {
    
    /// 思路: windowArray为双端队列 保存数组角标, 并按照降序排列, 头部为当前最大值, (需要判断是否有效,即是否在窗口区间), 如果j遍历到非降序,则把比他小的值从头部推出.
    
    func maxSlidingWindow(_ nums: [Int], _ k: Int) -> [Int] {
        if k < 0 {
            return [Int]()
        }
        if k == 1 {
            return nums
        }
        var windowArray = [Int]()
        var i = 0 - (k-1)
        var j = 0
        
        var resuleArray = [Int]()
        
        while j < nums.count {
            
            let value = nums[j]
            for index in windowArray.reversed() {
                let winValue = nums[index]
                if winValue <= value {
                    windowArray.removeLast()
                }
            }
            windowArray.append(j)
            if i >= 0 {
                while windowArray[0] > j || windowArray[0] < i {
                    windowArray.removeFirst()
                }
                resuleArray.append(nums[windowArray[0]])
            }
            i = i + 1
            j = j + 1
        }
        
        return resuleArray
    }
}
