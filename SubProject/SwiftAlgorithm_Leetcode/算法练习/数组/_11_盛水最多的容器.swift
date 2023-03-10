//
//  _11_盛水最多的容器.swift
//  算法练习
//
//  Created by sharui on 2022/6/22.
//

import Foundation
/// https://leetcode.cn/problems/container-with-most-water/submissions/
class _11_盛水最多的容器 {
    class Solution {
        func maxArea(_ height: [Int]) -> Int {
            if height.count == 0 {
                return 0
            }
            var i = 0
            var j = height.count - 1
            var maxValue = 0
            while i < j {
                maxValue = max((j - i) * min(height[i],height[j]),maxValue)
                if height[i] < height[j] {
                    i = i + 1
                }else {
                    j = j - 1
                }
            }
            return maxValue
            
        }
    }
}
