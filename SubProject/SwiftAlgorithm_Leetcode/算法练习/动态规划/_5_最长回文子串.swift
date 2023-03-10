//
//  _5_最长回文子串.swift
//  算法练习
//
//  Created by sharui on 2022/5/5.
//

import Foundation
class _5_最长回文子串 {
    
    /// 动态规划方法
    func longestPalindrome(_ s: String) -> String {
        /// 建立二维数组   i 为行  j 为列     i表示左侧index  j表示有测index
        ///  dp[i][j] =  dp[i + 1][j - 1] && s[i] == s[j]   因为用到j-1 所以先用列排
        ///   j - 1 - (i + 1) + 1 < 2   abc  ij是ac的情况
        ///
        var maxLenth = 1
        var begin = 0
        var dp = Array(repeating: Array(repeating:false, count: s.count), count: s.count)
        for i in 0..<s.count {
            dp[i][i] = true
        }
        let sArray = s.map{String($0)}
        let n = sArray.count
        for i in (0..<n - 1).reversed() {
            for j in (i + 1)..<n {
                if sArray[i] != sArray[j] {
                    dp[i][j] = false
                } else if j - i < 3 {
                    dp[i][j] = true
                } else {
                    dp[i][j] = dp[i + 1][j - 1]
                }
                
                if dp[i][j] == true && j - i + 1 > maxLenth {
                    begin = i
                    maxLenth = (j - i + 1)
                }
            }
        }
        return sArray[begin..<begin + maxLenth].joined()
    }
}


