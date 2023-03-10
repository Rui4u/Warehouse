//
//  _剑指_Offer_II_079_所有子集.swift
//  算法练习
//
//  Created by 沙睿 on 2022/5/31.
//

import Foundation

class _剑指_Offer_II_079_所有子集 {
    func subsets(_ nums: [Int]) -> [[Int]] {
        var subArray = [Int]()
        var resultArray = [[Int]]()
        let n = nums.count
        for mask in 0..<(1<<n) {
            subArray.removeAll()
            for j in 0..<n {
                if mask & (1<<j) != 0 {
                    subArray.append(nums[j])
                }
            }
            resultArray.append(subArray)
        }
        return resultArray
    }
}
