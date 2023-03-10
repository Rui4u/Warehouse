//
//  _剑指Offer_07_重建二叉树.swift
//  算法练习
//
//  Created by 沙睿 on 2022/5/31.
//

import Foundation

public class SRTreeNode {
      public var val: String
      public var left: SRTreeNode?
      public var right: SRTreeNode?
      public init(_ val: String) {
          self.val = val
          self.left = nil
          self.right = nil
      }
 }

class _剑指Offer_07_重建二叉树 {
    
    func postOrderByPreAndIn(_ preorder: [String], _ inorder: [String]) -> [String] {
        let root = buildTree(preorder, inorder)
        var list = [String]()
        postOrder(list: &list, root)
        return list
    }
    
    func buildTree(_ preorder: [String], _ inorder: [String]) -> SRTreeNode? {
        if preorder.count == 0  || inorder.count == 0 {
            return nil
        }
        if preorder.count == 1 {
            return SRTreeNode(preorder[0])
        }
        let rootValue = preorder[0]
        let root = SRTreeNode(rootValue)
        guard let preorderLeft = inorder.firstIndex(of: rootValue) else {
            return nil
        }
        let preorderRight  = preorderLeft + 1
        
        if 1 <= preorderLeft && 0 < preorderLeft {
            root.left = buildTree(Array(preorder[1...preorderLeft]), Array(inorder[0..<preorderLeft]))
            
        }
        
        if preorderLeft+1 <= preorder.count - 1 && preorderRight <= inorder.count - 1 {
            root.right = buildTree(Array(preorder[preorderLeft+1...preorder.count - 1]), Array(inorder[preorderRight...inorder.count - 1]))
        }
        
        return root
    }
    
    func postOrder(list: inout [String],  _ root: SRTreeNode? ){
        guard let root = root else {
            return;
        }
        
        postOrder(list: &list, root.left)
        postOrder(list: &list, root.right)
        list.append(root.val)
           
    }
}
