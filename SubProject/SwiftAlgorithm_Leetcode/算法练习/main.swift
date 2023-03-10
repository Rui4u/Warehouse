//
//  main.swift
//  算法练习
//
//  Created by 沙睿 on 2022/5/18.
//

import Foundation

//print("Hello, World!")
//var temp = [2,0,2,1,1,0]
//_75_颜色分类().sortColors(&temp)
//print(temp)

//print(_面试题16_16_部分排序().subSort([1,2,4,7,10,11,7,12,6,7,16,18,19]))

//var nums1 = [1,2,3,0,0,0], m = 3, nums2 = [2,5,6], n = 3
//_88_合并两个有序数组().merge(&nums1, m, nums2, n)
//print(nums1)
//_160_相交链表().getIntersectionNode(nil, nil)
//_86_分隔链表().partition(nil, 3)

//let preorder = [1,2], inorder = [2,1]
//_二叉树().buildTree(preorder, inorder)


//var header = ListNode(1)
//var node: ListNode? = header
//let list = [8,0,7,1,7,7,9,7,5,2,9,1,7,3,7,0,6,5,1,7,7,9,3,8,1,5,7,7,8,4,0,9,3,7,3,4,5,7,4,8,8,5,8,9,8,5,8,8,4,7,5,4,3,7,3,9,0,4,8,7,7,5,1,8,3,9,7,7,1,5,6,0,7,3,7,1,9,2,5,7,9,7,7,1,7,0,8]
//for i in list
// {
//    node?.next = ListNode(i)
//    node = node?.next
//}
//_234_回文链表().isPalindrome(header.next)

//_239_滑动窗口最大值().maxSlidingWindow([1,3,-1,-3,5,3,6,7], 3)
//
//var root = TreeNode(3)
//root.left = TreeNode(9)
//root.right = TreeNode(20)
//root.right?.left = TreeNode(15)
//root.right?.right = TreeNode(7)
//_102_二叉树的层序遍历().levelOrder(root)
//

//let node = _654_最大二叉树().constructMaximumBinaryTree([3,2,1,6,0,5])
//print(node)
//
//_739_每日温度().dailyTemperatures([73,74,75,71,69,72,76,73])
//_496_下一个更大元素().nextGreaterElement([1,3,5,2,4],[6,5,4,3,2,1,7])
//_503_下一个更大元素2().nextGreaterElements([100,1,11,1,120,111,123,1,-1,-100])
//_剑指_Offer_II_079_所有子集().subsets([1,2,3])
//_面试题_01_09_字符串轮转().isFlipedString("abcd","acdb")
//_3_无重复字符的最长子串().lengthOfLongestSubstring("abcabcbb")
//_剑指Offer_47_礼物的最大价值().maxValue([[1,3,1],[1,5,1],[4,2,1]])
//_剑指Offer_II_099_最小路径之和().minPathSum([[1,3,1],[1,5,1],[4,2,1]])
//AllSort().fastSort([-74,48,-20,2,10,-84,-5,4,5,2,1])
//_42_接雨水().trap([0,1,0,2,1,0,1,3,2,1,2,1])
//_5_最长回文子串().longestPalindrome("abceqdddfsdf")
//_395_至少有K个重复字符的最长子串().longestSubstring("adsfdsf", 2)
//
//
//class Solution {
//    func reverseKGroup(_ head: ListNode?, _ k: Int) -> ListNode? {
//        let newHeader = ListNode()
//        var currentHeader: ListNode? = newHeader
//        var currentOrginHeader = head
//        var tailNode: ListNode? = newHeader
//        var cheakNode: ListNode? = head
//        var i = 0
//        let j = i + k - 1
//        while i < j {
//            cheakNode = cheakNode?.next
//            i = i + 1
//        }
//        i = 0
//        while (currentOrginHeader != nil) {
//            if i % k == 0 {
//                while (tailNode?.next != nil) {
//                    tailNode = tailNode?.next
//                }
//                currentHeader = tailNode
//                if cheakNode == nil {
//                    tailNode?.next = currentOrginHeader
//                    break
//                }
//            }
//            let temp2 = currentOrginHeader?.next
//            let temp = currentHeader?.next
//            currentHeader?.next = currentOrginHeader
//            currentOrginHeader?.next = temp
//            currentOrginHeader = temp2
//
//            cheakNode = cheakNode?.next
//            i = i + 1
//        }
//        return newHeader.next
//    }
//}



