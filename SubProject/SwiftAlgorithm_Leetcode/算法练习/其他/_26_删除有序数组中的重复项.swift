//
//  _26_删除有序数组中的重复项.swift
//  算法练习
//
//  Created by sharui on 2022/4/29.
//

import Foundation

class _26_删除有序数组中的重复项 {
    func removeDuplicates(_ nums: inout [Int]) -> Int {
        if nums.count == 0 {
            return 0
        }
        var slowly = 0
        var fast = 0
        
        while fast < nums.count {
            if nums[fast] != nums[slowly] {
                slowly = slowly + 1
                nums[slowly] = nums[fast]
            }
            fast = fast + 1
        }
        return slowly + 1
    }
}
