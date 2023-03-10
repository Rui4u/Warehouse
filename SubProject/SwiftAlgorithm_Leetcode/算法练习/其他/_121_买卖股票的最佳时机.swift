//
//  _121_买卖股票的最佳时机.swift
//  算法练习
//
//  Created by sharui on 2022/2/15.
//

import Foundation
class _121_买卖股票的最佳时机 {
    func maxProfit(_ prices: [Int]) -> Int {
        var min = Int.max
        var inCome = 0
        for price in prices {
            if price < min {
                min = price
            }
            if inCome < price - min {
                inCome = price - min
            }
        }
        return inCome
    }
}
