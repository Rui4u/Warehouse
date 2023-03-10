//
//  _234_回文链表.swift
//  算法练习
//
//  Created by 沙睿 on 2022/5/31.
//

import Foundation

/// https://leetcode.cn/problems/palindrome-linked-list/
/// 思想  倒转把后半部分  空间复杂度O(1) 时间复杂度O(n)
class _234_回文链表 {
    func isPalindrome(_ head: ListNode?) -> Bool {
        var firstHeader = head
        let midNode = findMiddle(head)
        var newNodel = reverNode(midNode?.next)
        printNode(firstHeader)
        printNode(newNodel)
        var list = [Int]()
        while firstHeader?.val == newNodel?.val {
            if newNodel == nil {
                return true
            }
            firstHeader = firstHeader?.next
            newNodel = newNodel?.next
            list.append(firstHeader!.val)
        }
        
        if newNodel == nil {
            return true
        }
        
        return false
    }
    // 1  2  3  4
    
    func findMiddle(_ head: ListNode?) -> ListNode? {
        var slowNode = head
        var fastNode = head
        while fastNode?.next != nil && fastNode?.next?.next != nil {
            slowNode = slowNode?.next
            fastNode = fastNode?.next?.next
        }
        return slowNode
    }
    
    func reverNode (_ head: ListNode?) -> ListNode? {
        var oldNode = head
        var newNode : ListNode?
        while oldNode != nil {
            let temp = oldNode?.next
            oldNode?.next = newNode
            newNode = oldNode
            oldNode = temp
        }
        return newNode
    }
    func printNode(_ head: ListNode?) {
        var header = head
        var list = [Int]()
        while header != nil {
            list.append(header!.val)
            header = header?.next
        }
        print(list)
    }
}
