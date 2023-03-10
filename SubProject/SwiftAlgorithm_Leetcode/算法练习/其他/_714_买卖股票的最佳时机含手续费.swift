//
//  _714_买卖股票的最佳时机含手续费.swift
//  算法练习
//
//  Created by sharui on 2022/2/15.
//

import Foundation

class _714_买卖股票的最佳时机含手续费 {
    func maxProfit(_ prices: [Int], _ fee: Int) -> Int {
        let n = prices.count
        var has = Array(repeating: 0, count: prices.count)
        var noHas = Array(repeating: 0, count: prices.count)
        
        has[0] = -prices[0]
        noHas[0] = 0
        
        for i in 1..<prices.count {
            has[i] = max(has[i - 1], noHas[i - 1] - prices[i])
            noHas[i] = max(noHas[i - 1], has[i - 1] - fee + prices[i])
        }
        return max(has[n - 1], noHas[n - 1])
    }
}
