//
//  _395_至少有 K 个重复字符的最长子串.swift
//  算法练习
//
//  Created by sharui on 2022/7/12.
//

import Foundation
class _395_至少有K个重复字符的最长子串 {
    
    /// 利用map记录个数，遍历map找到小于k的元素，并依此分隔后递归
    /// 因为是最长，所以只要所有元素都大于k即可
    func longestSubstring(_ s: String, _ k: Int) -> Int {
        if s.count < k {
            return 0
        }
        var map = [Character: Int]()
        for c in s {
            map[c] = (map[c] ?? 0) + 1
        }

        for key in map.keys{
            if map[key]! < k {
                var res = 0
                for sub in s.split(separator: key) {
                    res = max(res, longestSubstring(String(sub),k))
                }
                return res;
            }
        }
        return s.count;
    }
}
