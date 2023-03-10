//
//  _34_在排序数组中查找元素的第一个和最后一个位置.swift
//  算法练习
//
//  Created by sharui on 2022/5/9.
//

import Foundation
class _34_在排序数组中查找元素的第一个和最后一个位置 {
    func searchRange(_ nums: [Int], _ target: Int) -> [Int] {
        if nums.count == 0 {
            return [-1, -1]
        }
        var markLeft = -1
        var markRight = -1
        markRight = findLeftOrRight(nums: nums, target: target, isLeft: false)
        markLeft = findLeftOrRight(nums: nums, target: target, isLeft: true)
       
        if markLeft <= markRight && markRight < nums.count && nums[markLeft] == target && nums[markRight] == target {
            return [markLeft, markRight]
        }
        
        return [-1,-1]
    }
    
    func findLeftOrRight(nums:[Int], target:Int, isLeft:Bool)-> Int {
        var left = 0
        var right = nums.count - 1
        while (left <= right) {
            let mid = left + (right - left) / 2
            if nums[mid] == target {
                if isLeft {
                    right = mid - 1
                } else {
                    left = mid + 1
                }
                
            } else if nums[mid] < target {
                left = mid + 1
            } else if nums[mid] > target {
                right = mid - 1
            }
        }
        
        if isLeft {
            return right + 1
        } else {
            return left - 1
        }
    }
}
