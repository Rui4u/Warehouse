//
//  _面试题_01_09_字符串轮转.swift
//  算法练习
//
//  Created by 沙睿 on 2022/6/1.
//

import Foundation
class _面试题_01_09_字符串轮转 {
    func isFlipedString(_ s1: String, _ s2: String) -> Bool {
        if s1.count != s2.count {
            return false
        }
        if s1.count == 0 {
            return true
        }
        let s3 = s1 + s1
        /// 可以考虑KMP算法
        return s3.contains(s2)
    }
}
