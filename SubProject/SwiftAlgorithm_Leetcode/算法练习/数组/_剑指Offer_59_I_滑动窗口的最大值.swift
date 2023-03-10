//
//  _剑指Offer_59_I_滑动窗口的最大值.swift
//  算法练习
//
//  Created by sharui on 2022/6/17.
//

import Foundation

/// 利用双端队列
class _剑指Offer_59_I_滑动窗口的最大值 {
    var queue = [Int]()
    var result = [Int]()
    func maxSlidingWindow(_ nums: [Int], _ k: Int) -> [Int] {
        if nums.count == 0 {
            return [Int]()
        }
        var i = 0
        var maxValue = nums[0]
        while(i < k) {
            queue.append(nums[i])
            if nums[i] > maxValue {
                maxValue = nums[i]
            }
            i = i + 1
        }
        result.append(maxValue)
        
        for i in k..<nums.count {
            queue.append(nums[i])
            let first = queue.removeFirst()
            if first != maxValue {
                maxValue = max(maxValue, nums[i])
                result.append(maxValue)
                continue
            } else {
                maxValue = nums[i]
                for j in 0..<queue.count {
                    maxValue = max(maxValue,queue[j])
                }
            }
            result.append(maxValue)
        }
        return result
    }
}
