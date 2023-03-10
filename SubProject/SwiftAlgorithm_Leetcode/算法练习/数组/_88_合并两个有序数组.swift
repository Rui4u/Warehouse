//
//  _88_合并两个有序数组.swift
//  算法练习
//
//  Created by 沙睿 on 2022/5/24.
//

import Foundation
class _88_合并两个有序数组 {
    func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
        var i = m - 1
        var j = n - 1
        var tail = m + n - 1
        var cur = 0
        while(i >= 0 || j >= 0) {
            
            if i == -1 {
                cur = nums2[j]
                j = j - 1
            } else if j == -1 {
                cur = nums1[i]
                i = i - 1
            } else if nums1[i] < nums2[j] {
                cur = nums2[j]
                j = j - 1
            } else {
                cur = nums1[i]
                i = i - 1
            }
            nums1[tail] = cur
            tail = tail - 1
        }
       
    }
}

