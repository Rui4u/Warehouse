//
//  _剑指Offer_II_099_最小路径之和.swift
//  算法练习
//
//  Created by 沙睿 on 2022/6/6.
//

import Foundation
class _剑指Offer_II_099_最小路径之和 {
    func minPathSum(_ grid: [[Int]]) -> Int {
        if grid.count == 0 {
            return 0
        }
        let row = grid.first!.count
        let col = grid.count
        
        var dp = Array(repeating: Array(repeating: 0, count: row), count: col)
        
        for c in 0..<col {
            for r in 0..<row {
                let dpc = c - 1
                let dpr = r - 1
                if c == 0 && r == 0 {
                    dp[c][r] = grid[c][r]
                } else {
                    if dpc < 0 {
                        dp[c][r] = dp[c][dpr] + grid[c][r]
                    } else if dpr < 0{
                        dp[c][r] = dp[dpc][r] + grid[c][r]
                    } else{
                        dp[c][r] = min(dp[dpc][r], dp[c][dpr]) + grid[c][r]
                    }
                    
                }
            }
        }
        return dp[col - 1][row - 1]
    }
}
