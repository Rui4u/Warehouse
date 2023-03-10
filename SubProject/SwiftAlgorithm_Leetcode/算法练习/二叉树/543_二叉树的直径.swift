//
//  543_二叉树的直径.swift
//  算法练习
//
//  Created by sharui on 2022/6/22.
//

import Foundation
/// https://leetcode.cn/problems/diameter-of-binary-tree/
class _543_二叉树的直径 {
    var ans = 1
    func diameterOfBinaryTree(_ root: TreeNode?) -> Int {
        _ = deep(root);
        return ans - 1
    }
    func deep(_ root: TreeNode?) -> Int{
        if root == nil {
            return 0
        }
        let left = deep(root!.left)
        let right = deep(root!.right)
        ans = max(left + right + 1, ans);
        return max(left + 1, right + 1)
    }
}
