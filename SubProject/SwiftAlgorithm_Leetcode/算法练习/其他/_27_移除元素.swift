//
//  _27_移除元素.swift
//  算法练习
//
//  Created by sharui on 2022/4/29.
//

import Foundation
/// 输入：nums = [3,2,2,3], val = 3
//输出：2, nums = [2,2]
//解释：函数应该返回新的长度 2, 并且 nums 中的前两个元素均为 2。你不需要考虑数组中超出新长度后面的元素。例如，函数返回的新长度为 2 ，而 nums = [2,2,3,3] 或 nums = [2,2,0,0]，也会被视作正确答案。
//
//来源：力扣（LeetCode）
//链接：https://leetcode-cn.com/problems/remove-element
//著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
class _27_移除元素 {
    func removeElement(_ nums: inout [Int], _ val: Int) -> Int {
        if nums.count == 0  {
            return 0
        }
        var slow = 0
        var fast = 0
        while fast < nums.count {
            if nums[fast] != val {
                nums[slow] = nums[fast]
                slow  = slow + 1
            }
            fast = fast + 1
        }
        return slow
    }
}
