//
//  _86_分隔链表.swift
//  算法练习
//
//  Created by 沙睿 on 2022/5/31.
//

import Foundation

/// 给你一个链表的头节点 head 和一个特定值 x ，请你对链表进行分隔，使得所有 小于 x 的节点都出现在 大于或等于 x 的节点之前。
/// 你应当 保留 两个分区中每个节点的初始相对位置。
/// 链接：https://leetcode.cn/problems/partition-list
class _86_分隔链表 {
    func partition(_ head: ListNode?, _ x: Int) -> ListNode? {
        
        var leftHeader :ListNode?
        var leftTail: ListNode?
        var rightHeader: ListNode?
        var rightTail: ListNode?
        var current = head
        
        while current != nil {
            let temp = current?.next
            if current!.val < x {
                if leftHeader == nil {
                    leftHeader = current
                } else {
                    leftTail?.next = current
                }
                leftTail = current
            } else {
                if rightHeader == nil {
                    rightHeader = current
                } else {
                    rightTail?.next = current
                }
                rightTail = current
            }
            current?.next = nil
            current = temp
        }
        
        if leftTail == nil {
            leftHeader = rightHeader
        }
        leftTail?.next = rightHeader
        
        return leftHeader
    }
}
