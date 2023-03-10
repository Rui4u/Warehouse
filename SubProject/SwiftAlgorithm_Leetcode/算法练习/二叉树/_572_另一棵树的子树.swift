//
//  _572_另一棵树的子树.swift
//  算法练习
//
//  Created by 沙睿 on 2022/6/1.
//

import Foundation
class _572_另一棵树的子树 {
    
    /// 通过递归+字符串方式判断  递归出前序或者后序遍历,生成字符串. 注意子节点为nil的时候需要字符串代替
    /// 有值在前面加上"!"+value  空为"#!", 如果是先序遍历 "!"+value  后序遍历 value + "!" ,防止出现以下情况
    /// [12] [2]
    /// !12#!#!  !2#!#!
    /// - Parameters:
    ///   - root: <#root description#>
    ///   - subRoot: <#subRoot description#>
    /// - Returns: <#description#>
    func isSubtree(_ root: TreeNode?, _ subRoot: TreeNode?) -> Bool {
        let s1 = preorderTraversal(root)
        let s2 = preorderTraversal(subRoot)
        return s1.contains(s2)
    }
    
    func preorderTraversal(_ root: TreeNode?) -> String{
        if root == nil {
            return "#!"
        } else {
            return "!" + String(root!.val) + preorderTraversal(root?.left) + preorderTraversal(root?.right)
        }
    }
    
    
    /// 通过递归的方式判断
    /// - Parameters:
    ///   - root: <#root description#>
    ///   - subRoot: <#subRoot description#>
    /// - Returns: <#description#>
    func isSubtree2(_ root: TreeNode?, _ subRoot: TreeNode?) -> Bool {
        return dfs(root, subRoot)
    }
    
    func cheak(_ root: TreeNode?, _ subRoot: TreeNode?) ->Bool{
        if root == nil && subRoot == nil {
            return true
        }
        guard let root = root , let subRoot = subRoot else {
            return false
        }
        if root.val != subRoot.val {
            return false
        }
        return cheak(root.left, subRoot.left) && cheak(root.right, subRoot.right)
    }
    
    func dfs(_ root: TreeNode?, _ subRoot: TreeNode?) -> Bool {
        if root == nil {
            return false
        }
        return cheak(root,subRoot) || dfs(root?.left, subRoot) || dfs(root?.right, subRoot)
    }
}
