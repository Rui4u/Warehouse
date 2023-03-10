//
//  _1094_拼车.swift
//  算法练习
//
//  Created by sharui on 2022/5/5.
//

import Foundation
/// 差分数组技巧
class _1094_拼车 {
    
    func carPooling(_ trips: [[Int]], _ capacity: Int) -> Bool {
        
        var maxStation = 0
        for trip in trips {
            maxStation =  maxStation > (trip.last ?? 0) ? maxStation : (trip.last ?? 0)
        }
        
        var diff = Array(repeating: 0, count: maxStation)
    
        for trip in trips {
            let num = trip[0]
            let begin = trip[1]
            let end = trip[2]
            diff[begin] = diff[begin] + num
            if end < diff.count {
                diff[end] = diff[end] - num
            }
        }
        
        var orgin = Array(repeating: 0, count: maxStation)
        orgin[0] = diff[0]
        var max = orgin[0]
        for i in 1..<diff.count {
            orgin[i] = diff[i] + orgin[i - 1]
            if orgin[i] > max {
                max = orgin[i]
            }
        }
        
        return max <= capacity
    }
    
   
}
