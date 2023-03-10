//
//  _1014_最佳观光组合.swift
//  算法练习
//
//  Created by sharui on 2022/2/15.
//

import Foundation
class _1014_最佳观光组合 {
    func maxScoreSightseeingPair(_ values: [Int]) -> Int {
        var ans = 0
        var mx = values[0] + 0
        for i in 1..<values.count {
            ans = max(ans, mx + values[i] - i)
            mx = max(mx, values[i] + i)
        }
        return ans
    }
}
