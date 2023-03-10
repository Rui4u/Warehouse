//
//  _25_K个一组翻转链表.swift
//  算法练习
//
//  Created by sharui on 2022/7/20.
//

import Foundation
class _25_K个一组翻转链表 {
    func reverseKGroup(_ head: ListNode?, _ k: Int) -> ListNode? {
        let newHeader = ListNode()
        var currentHeader: ListNode? = newHeader
        var currentOrginHeader = head
        var tailNode: ListNode? = newHeader
        var cheakNode: ListNode? = head
        var i = 0
        let j = i + k - 1
        while i < j {
            cheakNode = cheakNode?.next
            i = i + 1
        }
        i = 0
        while (currentOrginHeader != nil) {
            if i % k == 0 {
                while (tailNode?.next != nil) {
                    tailNode = tailNode?.next
                }
                currentHeader = tailNode
                if cheakNode == nil {
                    tailNode?.next = currentOrginHeader
                    break
                }
            }
            let temp2 = currentOrginHeader?.next
            let temp = currentHeader?.next
            currentHeader?.next = currentOrginHeader
            currentOrginHeader?.next = temp
            currentOrginHeader = temp2
            
            cheakNode = cheakNode?.next
            i = i + 1
        }
        return newHeader.next
    }
}
