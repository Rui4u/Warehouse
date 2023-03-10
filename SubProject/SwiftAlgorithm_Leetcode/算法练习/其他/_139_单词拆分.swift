//
//  _139_单词拆分.swift
//  算法练习
//
//  Created by sharui on 2022/2/22.
//

import Foundation
class _139_单词拆分 {
    

    func wordBreak(_ s: String, _ wordDict: [String]) -> Bool {
        var dp = Array(repeating: false, count: s.count + 1)
        dp[0] = true
        for i in 0..<s.count {
            for j in i+1...s.count {
                let leftIndex = s.index(s.startIndex, offsetBy: i);
                let rightIndex = s.index(s.startIndex, offsetBy:j);
                let subString = String(s[leftIndex..<rightIndex])
                print(subString)
                if dp[i] && wordDict.contains(subString) {
                    dp[j] = true
                }
            }
            print("=====")
        }
        return dp[s.count];
    }
}
