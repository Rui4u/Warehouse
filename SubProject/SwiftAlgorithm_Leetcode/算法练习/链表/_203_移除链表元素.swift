//
//  _链表.swift
//  算法练习
//
//  Created by 沙睿 on 2022/5/24.
//

import Foundation

public class ListNode {
      public var val: Int
      public var next: ListNode?
      public init() { self.val = 0; self.next = nil; }
      public init(_ val: Int) { self.val = val; self.next = nil; }
      public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
 }

class _203_移除链表元素 {
    func removeElements(_ head: ListNode?, _ val: Int) -> ListNode? {
        var current = head
        while(current?.val == val) {
            current = current?.next
        }
        let newHeader = current
        while current != nil {
            if current?.next?.val == val {
                current?.next = current?.next?.next
            }
            if current?.val != val {
                current = current?.next
            }
        }
        return newHeader
    }
}


