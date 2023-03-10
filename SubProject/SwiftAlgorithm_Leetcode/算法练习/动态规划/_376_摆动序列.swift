//
//  _376_摆动序列.swift
//  算法练习
//
//  Created by sharui on 2022/6/21.
//

import Foundation
/// https://leetcode.cn/problems/wiggle-subsequence/
/// 例如， [1, 7, 4, 9, 2, 5] 是一个 摆动序列 ，因为差值 (6, -3, 5, -7, 3) 是正负交替出现的。
class _376_摆动序列 {
    func wiggleMaxLength(_ nums: [Int]) -> Int {
        var lenth = nums.count
        if lenth <= 1 {
            return lenth
        }
        var up = Array(repeating: 1, count: nums.count)
        var down = Array(repeating: 1, count: nums.count)
        
        for i in 1..<lenth {
            if nums[i] > nums[i - 1] { //上升
                down[i] = down[i - 1]
                up[i] = max(down[i - 1] + 1, up[i - 1])
            } else if nums[i] < nums[i - 1] { //下降
                up[i] = up[i - 1]
                down[i] = max(up[i - 1] + 1, down[i - 1])
            } else {
                up[i] = up[i - 1]
                down[i] = down[i - 1]
            }
        }
        return max(up[lenth - 1], down[lenth - 1])
    }
}
