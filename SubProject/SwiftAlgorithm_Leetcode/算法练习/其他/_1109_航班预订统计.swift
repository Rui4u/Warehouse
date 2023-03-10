//
//  _1109_航班预订统计.swift
//  算法练习
//
//  Created by sharui on 2022/5/5.
//
import Foundation

/// 差分数组技巧
// 1109. 航班预订统计
// 这里有 n 个航班，它们分别从 1 到 n 进行编号。
//
// 有一份航班预订表 bookings ，表中第 i 条预订记录 bookings[i] = [firsti, lasti, seatsi] 意味着在从 firsti 到 lasti （包含 firsti 和 lasti ）的 每个航班 上预订了 seatsi 个座位。
//
// 请你返回一个长度为 n 的数组 answer，里面的元素是每个航班预定的座位总数。

class _1109_航班预订统计 {
    func corpFlightBookings(_ bookings: [[Int]], _ n: Int) -> [Int] {
        var diff = Array(repeating: 0, count: n)
    
        for booking in bookings {
            let num = booking[2]
            let begin = booking[0] - 1
            let end = booking[1]
            diff[begin] = diff[begin] + num
            if end < diff.count {
                diff[end] = diff[end] - num
            }
        }
        
        var orgin = Array(repeating: 0, count: n)
        orgin[0] = diff[0]
        for i in 1..<diff.count {
            orgin[i] = diff[i] + orgin[i - 1]
        }
        
        
        return orgin
    }
}
