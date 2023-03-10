//
//  _152_乘积最大子数组.swift
//  算法练习
//
//  Created by sharui on 2022/2/14.
//

import Foundation
///
///给你一个整数数组 nums ，请你找出数组中乘积最大的非空连续子数组（该子数组中至少包含一个数字），并返回该子数组所对应的乘积。
//测试用例的答案是一个 32-位 整数。
//
//子数组 是数组的连续子序列。
//
//
//
//示例 1:
//
//输入: nums = [2,3,-2,4]
//输出: 6
//解释: 子数组 [2,3] 有最大乘积 6。
//示例 2:
//
//输入: nums = [-2,0,-1]
//输出: 0
//解释: 结果不能为 2, 因为 [-2,-1] 不是子数组。
//
//来源：力扣（LeetCode）
//链接：https://leetcode-cn.com/problems/maximum-product-subarray
//著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
class _152_乘积最大子数组 {
    func maxProduct(_ nums: [Int]) -> Int {
        
        var dp = Array(repeating: 1, count: nums.count)
        var dp2 = Array(repeating: 1, count: nums.count)
        dp[0] = nums[0]
        dp2[0] = nums[0]
        
        for i in 1..<nums.count {
            let num = nums[i]
            dp[i] = max(max(dp[i - 1] * num, num), dp2[i - 1] * num)
            dp2[i] = min(min(dp2[i - 1] * num, num), dp[i - 1] * num)
        }
        var result = dp[0]
        for value in dp {
            result = max(result, value)
        }
        return result
    }
}
