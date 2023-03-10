//
//  _1567_乘积为正数的最长子数组长度.swift
//  算法练习
//
//  Created by sharui on 2022/2/14.
//

import Foundation
class _1567_乘积为正数的最长子数组长度 {
    func getMaxLen(_ nums: [Int]) -> Int {
        var positives = Array(repeating: 0, count: nums.count)
        var negatives = Array(repeating: 0, count: nums.count)
        
        if nums[0] > 0 {
            positives[0] = 1
        } else if nums[0] < 0 {
            negatives[0] = 1
        }
        
        var maxCount = positives[0]
        
        for i in 1..<nums.count {
            let num = nums[i]
            if num > 0 {
                positives[i] = positives[i - 1] + 1
                let preNegativeValue = negatives[i - 1]
                if preNegativeValue > 0 {
                    negatives[i] = preNegativeValue + 1
                } else {
                    negatives[i] = 0
                }
            } else if num < 0 {
                if negatives[i - 1] > 0 {
                    positives[i] = negatives[i - 1] + 1
                } else {
                    positives[i] = 0
                }
                negatives[i] = positives[i - 1] + 1
            } else {
                positives[i] = 0
                negatives[i] = 0
            }
            maxCount = max(maxCount, positives[i])
        }
        return maxCount
    }
}
