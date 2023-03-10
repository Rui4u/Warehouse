//
//  _303_区域和检索 - 数组不可变.swift
//  算法练习
//
//  Created by sharui on 2022/5/5.
//

import Foundation
//给定一个整数数组  nums，处理以下类型的多个查询:
//
//计算索引 left 和 right （包含 left 和 right）之间的 nums 元素的 和 ，其中 left <= right
//实现 NumArray 类：
//
//NumArray(int[] nums) 使用数组 nums 初始化对象
//int sumRange(int i, int j) 返回数组 nums 中索引 left 和 right 之间的元素的 总和 ，包含 left 和 right 两点（也就是 nums[left] + nums[left + 1] + ... + nums[right] )
//
//
//来源：力扣（LeetCode）
//链接：https://leetcode-cn.com/problems/range-sum-query-immutable
//著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
class _303_区域和检索_数组不可变 {
    var preNums: Array<Int>!
    init(_ nums: [Int]) {
        preNums = Array(repeating: 0, count: nums.count + 1)
        for index in 1..<preNums.count {
            preNums[index] = preNums[index - 1] + nums[index - 1]
        }
    }
    
    func sumRange(_ left: Int, _ right: Int) -> Int {
        return preNums[right + 1] - preNums[left]
    }
}
