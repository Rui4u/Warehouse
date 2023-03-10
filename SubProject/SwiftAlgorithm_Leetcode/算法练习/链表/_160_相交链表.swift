//
//  _160_相交链表.swift
//  算法练习
//
//  Created by 沙睿 on 2022/5/31.
//

import Foundation
class _160_相交链表 {
    func getIntersectionNode(_ headA: ListNode?, _ headB: ListNode?) -> ListNode? {
        var cA = headA
        var cB = headB
        
        while cA !== cB  {
            cA = cA == nil ? headB : cA?.next
            cB = cB == nil ? headA : cB?.next
        }
        return cA
    }
}
