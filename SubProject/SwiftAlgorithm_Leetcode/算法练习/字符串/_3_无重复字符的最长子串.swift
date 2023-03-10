//
//  _3_无重复字符的最长子串.swift
//  算法练习
//
//  Created by 沙睿 on 2022/6/6.
//

import Foundation
/// 思路: 类似动态规划
/// 当遍历到 i的时候, 找到上一个i-1个字母的最长子串的起始位置li, 在找到[i]的字母上一次出现的位置存在map中p1
/// 取p1和li的最大值,也就是离i最近的位置
///
/// map 中存的是每一个字符上一次出现的位置
/// li保存i-1位置最长不重复字符串开始索引
/// https://leetcode.cn/problems/longest-substring-without-repeating-characters/
class _3_无重复字符的最长子串 {
    func lengthOfLongestSubstring(_ s: String) -> Int {
        if s.count == 0 {
            return 0
        }
        var map = [Character : Int]()
        var ans = 1
        var li = 0
        let array = Array(s)
        for i in 0..<array.count {
            li = max(map[array[i]] ?? 0, li)
            ans = max(i - li + 1, ans)
            map.updateValue(i + 1, forKey: array[i])
        }
        return ans
    }
}
