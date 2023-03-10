//
//  _剑指Offer_47_礼物的最大价值.swift
//  算法练习
//
//  Created by 沙睿 on 2022/6/6.
//

import Foundation
class _剑指Offer_47_礼物的最大价值 {
    func maxValue(_ grid: [[Int]]) -> Int {
        if grid.count == 0 {
            return 0
        }
        let row = grid.first!.count
        let col = grid.count
        
        var dp : [[Int]] = Array(repeating: Array(repeating: 0, count: row), count: col)
        
        for c in 0..<col {
            for r in 0..<row {
                let dpcol = c - 1 >= 0 ? c - 1 : 0
                let dprow = r - 1 >= 0 ? r - 1 : 0
                if r == 0 && c == 0 {
                    dp[c][r] = grid[c][r]
                } else {
                    dp[c][r] = max(dp[dpcol][r], dp[c][dprow]) + grid[c][r]
                }
                

            }
        }
        return dp[col-1][row-1]
    }
}
