//
//  _剑指Offer_63_股票的最大利润.swift
//  算法练习
//
//  Created by sharui on 2022/6/20.
//

import Foundation
class _剑指Offer_63_股票的最大利润 {
    func maxProfit(_ prices: [Int]) -> Int {
        if prices.count == 0 {
            return 0
        }
        // 0 持有   1未持有
        var pd = Array(repeating:[0,0],count:prices.count)
        pd[0][0] = -prices[0]

        for i in 1..<prices.count {
            // 持有可能  昨天未持有 和今天才持有的最大值
            pd[i][0] = max(-prices[i],pd[i-1][0])
            // 未持有  昨天持有 今天卖了，  昨天未持有
            pd[i][1] = max(prices[i] + pd[i - 1][0], pd[i - 1][1])
        }
        return max(pd[prices.count - 1][0],pd[prices.count - 1][1])
    }
}
