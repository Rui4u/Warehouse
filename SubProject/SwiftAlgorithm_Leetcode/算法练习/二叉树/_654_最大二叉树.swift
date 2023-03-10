//
//  _二叉树.swift
//  算法练习
//
//  Created by 沙睿 on 2022/5/29.
//

import Foundation
/**
 * Definition for a binary tree node.
*/

public class TreeNode {
      public var val: Int
      public var left: TreeNode?
      public var right: TreeNode?
      public init(_ val: Int) {
          self.val = val
          self.left = nil
          self.right = nil
      }
 }



/// https://leetcode.cn/problems/maximum-binary-tree/
class _654_最大二叉树 {
    func constructMaximumBinaryTree(_ nums: [Int]) -> TreeNode? {
        return construct(nums, left: 0, right: nums.count)
    }
    
    func construct(_ nums: [Int], left: Int, right: Int) -> TreeNode? {
        guard left < right else {
            return nil
        }
        
        let rootIndex = findMaxValue(nums, left: left, right: right)
        let root = TreeNode(nums[rootIndex])
        root.left = construct(nums, left: left, right: rootIndex)
        root.right = construct(nums, left: rootIndex + 1, right: right)
        return root
    }
    
    
    
    /// 找到区间内的节点
    /// - Parameters:
    ///   - _nums: 数组
    ///   - left: 左开
    ///   - right: 右闭
    /// - Returns: 角标
    func findMaxValue(_ nums: [Int], left: Int, right: Int) -> (Int) {
        var maxValue = Int.min
        var midx = 0
        for index in left..<right {
            if nums[index] > maxValue {
                maxValue = nums[index]
                midx = index
            }
        }
        return midx
    }
}








