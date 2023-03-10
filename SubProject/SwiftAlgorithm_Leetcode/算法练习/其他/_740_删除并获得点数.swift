//
//  740_删除并获得点数.swift
//  算法练习
//
//  Created by sharui on 2022/2/11.
//

import Foundation

//740. 删除并获得点数
//给你一个整数数组 nums ，你可以对它进行一些操作。
//
//每次操作中，选择任意一个 nums[i] ，删除它并获得 nums[i] 的点数。之后，你必须删除 所有 等于 nums[i] - 1 和 nums[i] + 1 的元素。
//
//开始你拥有 0 个点数。返回你能通过这些操作获得的最大点数。
//
//
//
//示例 1：
//
//输入：nums = [3,4,2]
//输出：6
//解释：
//删除 4 获得 4 个点数，因此 3 也被删除。
//之后，删除 2 获得 2 个点数。总共获得 6 个点数。
//示例 2：
//
//输入：nums = [2,2,3,3,3,4]
//输出：9
//解释：
//删除 3 获得 3 个点数，接着要删除两个 2 和 4 。
//之后，再次删除 3 获得 3 个点数，再次删除 3 获得 3 个点数。
//总共获得 9 个点数。
//
//
//提示：
//
//1 <= nums.length <= 2 * 104
//1 <= nums[i] <= 104
class _740_删除并获得点数 {
    func deleteAndEarn(_ nums: [Int]) -> Int {
        var maxItem = 0
        for item in nums {
            maxItem = max(item, maxItem)
        }
        
        var tempArray = Array(repeating: 0, count: maxItem + 1)
        for value in nums {
            tempArray[value] = tempArray[value] + value
        }
        return sub(tempArray)
    }
    
    func sub(_ nums: [Int]) -> Int {
        if nums.count == 0 {
            return 0
        }
        if nums.count == 1 {
            return nums[0]
        }
        var first = nums[0]
        var second = nums[1]
        
        for index in 2..<nums.count {
            let temp = second
            second = max(first + nums[index], second)
            first = temp
        }
        return second
    }
}
