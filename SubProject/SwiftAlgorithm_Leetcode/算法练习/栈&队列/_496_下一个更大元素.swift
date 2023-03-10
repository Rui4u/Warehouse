//
//  _496_下一个更大元素.swift
//  算法练习
//
//  Created by 沙睿 on 2022/5/31.
//

import Foundation
/// 思路:利用单调栈  单调递减
class _496_下一个更大元素 {
    func nextGreaterElement(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        var stack = [(Int,Int)]()  // 角标和数值
        var rMaxList = Array(repeating: -1, count:  nums2.count)
        var result = Array(repeating: -1, count:  nums1.count)
        var idx = 0
        for num in nums2 {
            if stack.count != 0 {
                if let last = stack.last {
                    if last.1 < num {
                        while stack.count > 0 ,let last2 = stack.last , last2.1 < num{
                            stack.removeLast()
                            rMaxList[last2.0] = idx - last2.0
                        }
                    }
                }
            }
            stack.append((idx,num))
            idx = idx + 1
        }
        
        var index = 0
        for nums in nums1 {
            if let idx = nums2.firstIndex(of:nums) {
                result[index] = rMaxList[idx] == -1  ?  -1 : nums2[rMaxList[idx] + idx]
            }
            index = index + 1
        }
        return result
    }
    
}
