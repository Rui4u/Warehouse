//
//  _242_有效的字母异位词.swift
//  算法练习
//
//  Created by 沙睿 on 2022/6/2.
//

import Foundation

/// 利用阿斯克码
class _242_有效的字母异位词 {
    func isAnagram(_ s: String, _ t: String) -> Bool {
        if s.count != t.count {return false}
        var record = Array(repeating: 0, count: 26)
        for unicode in t.unicodeScalars {
            let idx = Int(unicode.value - "a".unicodeScalars.first!.value)
            record[idx] = record[idx] + 1
        }
        
        for unicode in s.unicodeScalars {
            let idx = Int(unicode.value - "a".unicodeScalars.first!.value)
            record[idx] = record[idx] - 1
            if record[idx] < 0 {  // s和t中有不同的 必然有负数
                return false
            }
        }
        
        return true
    }
}
