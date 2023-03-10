//
//  _面试题16_16_部分排序.swift
//  算法练习
//
//  Created by 沙睿 on 2022/5/24.
//

import Foundation
/// 数组是递增的
/// 从左到右 找到最后一个逆序   找到最后一个递减序列
/// 从右到左 找到最后一个逆序   找到最后一个递增序列
///
class _面试题16_16_部分排序 {
    func subSort(_ array: [Int]) -> [Int] {
        var left = -1
        var right = -1
        
        var max = Int.min
        
        var index = 0
        for item in array {
            if item > max {
                max = item
            }
            if item < max {
                right = index
            }
            index = index + 1
        }
        
        if right == -1 {
            return [left, right]
        }
        
        var min = Int.max
        index = array.count - 1
        for item in array.reversed() {
            if item < min {
                min = item
            }
            if item > min {
                left = index
            }
            index = index - 1
        }
        
        return [left,right]
    }
}
