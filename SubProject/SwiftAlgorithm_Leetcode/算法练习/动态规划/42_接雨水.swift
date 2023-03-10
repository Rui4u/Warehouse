//
//  42_接雨水.swift
//  算法练习
//
//  Created by sharui on 2022/6/10.
//

import Foundation
class _42_接雨水 {
    /// 动态规划, 找到左右最高
    /// 累加
    func trap(_ height: [Int]) -> Int {

        if height.count <= 1 {
            return 0
        }
        var ldp = Array(repeating: 0, count: height.count)
        var rdp = Array(repeating: 0, count: height.count)
        
        for index in 1..<height.count {
            ldp[index] = max(ldp[index - 1], height[index - 1])
        }
        
        for index in (0..<height.count - 1).reversed() {
            rdp[index] = max(rdp[index + 1], height[index + 1])
        }
        
        var count = 0
        for index in 0..<height.count {
            print(rdp[index], ldp[index])
            let current = min(rdp[index], ldp[index]) - height[index]
            if current > 0 {
                count = current + count
            }
            
        }
        return count
    }
}
