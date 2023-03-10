//
//  _113_路径总和2.swift
//  算法练习
//
//  Created by sharui on 2022/6/14.
//

import Foundation
class _113_路径总和2 {
    
    var result = [[Int]]()
    var path = [Int]()
    
    func pathSum(_ root: TreeNode?, _ targetSum: Int) -> [[Int]] {
        traversal(root, target:targetSum)
        return result
    }

    func traversal(_ root: TreeNode?, target:Int) {
        if root == nil {
            return
        }

        path.append(root!.val)
        let tag = target - root!.val
        if root?.left == nil && root?.right == nil && tag == 0{
            result.append(path)
        }

        traversal(root?.left, target: tag)
        traversal(root?.right, target: tag)
        path.removeLast()
    
        
    }
}
