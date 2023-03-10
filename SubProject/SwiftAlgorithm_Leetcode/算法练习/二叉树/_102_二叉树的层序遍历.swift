//
//  _102_二叉树的层序遍历.swift
//  算法练习
//
//  Created by 沙睿 on 2022/5/31.
//

import Foundation
/// 102. 二叉树的层序遍历
class _102_二叉树的层序遍历 {
    func levelOrder(_ root: TreeNode?) -> [[Int]] {
        guard let root = root else {
            return [[Int]]()
        }

        var queue =  [TreeNode]()
        var result = [[Int]]()
        
        queue.append(root)
        while(queue.count > 0) {
            var level = [Int]()
            let count = queue.count
            for _ in 0..<count {
                let node = queue.removeFirst()
                if let left = node.left {
                    queue.append(left)
                }
                if let right = node.right {
                    queue.append(right)
                }
                level.append(node.val)
                
            }
            result.append(level)
        }
        return result
    }
}
