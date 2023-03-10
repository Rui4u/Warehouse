//
//  _122_买卖股票的最佳时机II.swift
//  算法练习
//
//  Created by sharui on 2022/2/15.
//

import Foundation
class _122_买卖股票的最佳时机II {
    func maxProfit(_ prices: [Int]) -> Int {
        var income = 0
        for i in 1..<prices.count {
            if prices[i - 1] < prices[i] {
                income = income + prices[i] - prices[i - 1]
            }
        }
        return income
    }
}

