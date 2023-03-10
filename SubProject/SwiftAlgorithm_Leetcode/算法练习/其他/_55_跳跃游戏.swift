//
//  _55_跳跃游戏.swift
//  算法练习
//
//  Created by sharui on 2022/2/11.
//

import Cocoa

class _55_跳跃游戏 {
    func canJump(_ nums: [Int]) -> Bool {
        var maxNums = 0
        var index = 0
        if nums.count == 1 {
            return true
        }
        
        for num in nums {
            if  index <= maxNums { //  防止出现如下情况 [3,2,1,0,4] 最大值必须大于当前角标, 如果不大于,则走不了下一个
                maxNums = max(num + index , maxNums)
                if maxNums > nums.count - 1 {
                    return true
                }
            }
            index = index + 1
        }
        return false
    }
}
