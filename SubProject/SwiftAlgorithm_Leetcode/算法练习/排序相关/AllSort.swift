//
//  AllSort.swift
//  算法练习
//
//  Created by sharui on 2022/6/9.
//

import Foundation
class AllSort {
    
    var emptyIndex = 0
    var beginRight = true
    /// 快速排序
    ///  选择一个   大于这个数的放左边, 小于这个数的放右边
    func fastSort(_ nums: [Int]) -> [Int] {
        var nums = nums
        fastSortRange(&nums, i: 0, leftIndex: 0, rightIndex: nums.count - 1)
        return nums
    }
    
    func fastSortRange(_ nums: inout [Int], i: Int, leftIndex: Int, rightIndex: Int) {
        if leftIndex >= rightIndex {
            return
        }
        
        var left = leftIndex
        var right = rightIndex
        let point = nums[i]
        emptyIndex = i
        beginRight = true
        
        while left < right {
            if beginRight {
                if nums[right] > point {
                    right = right - 1
                } else {
                    nums[left] = nums[right]
                    emptyIndex = right
                    beginRight = false
                    left = left + 1
                }
            } else {
                if nums[left] < point {
                    left = left + 1
                } else {
                    nums[right] = nums[left]
                    emptyIndex = left
                    beginRight = true
                    right = right - 1
                }
            }
            
            
        }
        nums[emptyIndex] = point
        fastSortRange(&nums, i: leftIndex, leftIndex: leftIndex, rightIndex: emptyIndex - 1)
        fastSortRange(&nums, i: emptyIndex + 1, leftIndex: emptyIndex + 1, rightIndex: rightIndex)
    }
    
    
    /// 堆排序    首先生成堆, 保证根节点最大
    ///  根节点与最后一个节点交换,  然后剩下堆继续完全二叉树化(根节点最大)
    ///  公式:
    ///  父节点   ( i - 1 ) /2    i为index
    ///  left 子节点 i * 2 + 1
    ///  right 子节点 i * 2 + 2
    /// - Parameter nums: <#nums description#>
    /// - Returns: <#description#>
    func heapSortArray(_ nums2: [Int]) -> [Int] {
        var nums = nums2
        // 构建完全二叉树
        buildTree(&nums)
        var index = nums.count - 1
        while index >= 0 {
            nums.swapAt(0, index)
            heapify(&nums, index: 0, count: index)
            index = index - 1
        }
        return nums
    }
    
    private func buildTree(_ nums: inout [Int]) {
        if nums.count < 2 {
            return
        }
        
        let lastParent =  ((nums.count - 1) - 1) / 2
        var index = lastParent
        while index >= 0 {
            heapify(&nums, index: index, count: nums.count)
            index = index - 1
        }
    }
    
    private func heapify(_ nums: inout [Int], index: Int, count: Int) {
        if index >= count {
            return
        }
        
        let lc = index * 2 + 1
        let rc = lc + 1
        var max = index
        
        if lc < count && nums[lc] > nums[max] {
            max = lc
        }
        
        if rc < count && nums[rc] > nums[max] {
            max = rc
        }
        
        if max != index {
            nums.swapAt(max, index)
        }
        heapify(&nums, index: lc, count: count)
        heapify(&nums, index: rc, count: count)
    }
    
    
    /// 选择排序   选出最大的和最后一个交换
    func sortArray(_ nums: [Int]) -> [Int] {
        var nums = nums
        for end in  (1..<nums.count).reversed() {
            var max = Int.min
            var maxIndex = 0
            for begin in 0..<end {
                if nums[begin] > max {
                    max = nums[begin]
                    maxIndex = begin
                }
            }
            if nums[maxIndex] > nums[end] {
                swap(nums: &nums, i: maxIndex, j: end)
            }
        }
        return nums
    }
    
    func swap(nums:inout [Int], i: Int, j:Int) {
        let value = nums[i]
        nums[i] = nums[j]
        nums[j] = value
    }
}
