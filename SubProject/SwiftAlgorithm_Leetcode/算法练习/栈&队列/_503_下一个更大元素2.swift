//
//  _503_下一个更大元素2.swift
//  算法练习
//
//  Created by 沙睿 on 2022/5/31.
//

import Foundation
class _503_下一个更大元素2 {
    func nextGreaterElements(_ nums: [Int]) -> [Int] {
        let nums1 = nums
        var nums2 = nums
        nums2 =  nums2 + nums
        
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
        for _ in nums1 {
            result[index] = rMaxList[index] == -1  ?  -1 : nums2[rMaxList[index] + index]
            index = index + 1
        }
        return result
    }
}
