//
//  _151_颠倒字符串中的单词.swift
//  算法练习
//
//  Created by 沙睿 on 2022/6/6.
//

import Foundation

/// 思路1 : 利用split和reversed
/// 思路2 : 1. 先去掉多余空格
///        2. 整体逆序
///        3. 每个单词逆序
class _151_颠倒字符串中的单词 {
    func reverseWords(_ s: String) -> String {
        return s.split { $0.isWhitespace }.reversed().joined(separator: " ")
    }
}

