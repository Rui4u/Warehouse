//
//  _309_最佳买卖股票时机含冷冻期.swift
//  算法练习
//
//  Created by sharui on 2022/2/15.
//

import Foundation

class _309_最佳买卖股票时机含冷冻期 {
    func maxProfit(_ prices: [Int]) -> Int {
        if prices.isEmpty {
            return 0
        }
     
        let n = prices.count
        /// 当天持有
        var o = Array(repeating: 0, count: n)
        /// 手上不持有 当天冷冻期
        var p = Array(repeating: 0, count: n)
        /// 当天不持有 且不在冷冻期
        var q = Array(repeating: 0, count: n)
        
        o[0] = -prices[0]
        p[0] = 0
        q[0] = 0
        
        for i in 1..<prices.count {
            o[i] = max(o[i - 1], q[i - 1] - prices[i])  //上一天持有 | 当天买入 取最大
            p[i] = o[i - 1] + prices[i]  // 当天买,昨天肯定持有, 昨天持有加上今天的收益
            q[i] = max(p[i - 1], q[i - 1])  // 昨天卖的 或者是昨天的不持有且不冷冻
        }
        return max(p[n - 1], q[n - 1])
    }
}
