//
//  _739_每日温度 .swift
//  算法练习
//
//  Created by 沙睿 on 2022/5/31.
//

import Foundation

/// https://leetcode.cn/problems/daily-temperatures/
class _739_每日温度 {
    /// 思想: 利用倒推法  从后向前找比自己大的值, 这样可以利用找到的结果进行运算,避免重复运算
    func dailyTemperatures(_ temperatures: [Int]) -> [Int] {

        var result = Array(repeating: 0, count: temperatures.count)
        for i in (0..<temperatures.count - 1).reversed() {
            var j = i + 1
            while true {
                if temperatures[i] < temperatures[j] {
                    result[i] = j - i
                    break
                } else if result[j] == 0 {
                    break
                } else if temperatures[i] == temperatures[j] {
                    result[i] = result[j] + j - i
                    break
                }else {
                    j = j + result[j]
                }
            }
        }
        return result
    }
    /// 思想: 利用单调栈 单调递减
    func dailyTemperatures2(_ temperatures: [Int]) -> [Int] {
        var stack = [(Int,Int)]()  // 角标和值
        var result = Array(repeating: 0, count: temperatures.count)
        var index = 0
        for temperature in temperatures {
            if let last = stack.last?.1 {
                if last > temperature {
                    stack.append((index,temperature))
                } else {
                    while stack.last?.1 ?? Int.min < temperature  && stack.count > 0{
                        if let temp = stack.popLast() {
                            result[temp.0] = index - temp.0
                        }
                    }
                    stack.append((index,temperature))
                }
            } else { //没有值
                stack.append((index,temperature))
            }
            index = index + 1
        }
        
        return result
    }
}
