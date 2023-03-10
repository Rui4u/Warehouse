//
//  _1011_在D天内送达包裹的能力.swift
//  算法练习
//
//  Created by sharui on 2022/5/9.
//

import Foundation
/**
 传送带上的包裹必须在 days 天内从一个港口运送到另一个港口。

 传送带上的第 i 个包裹的重量为 weights[i]。每一天，我们都会按给出重量（weights）的顺序往传送带上装载包裹。我们装载的重量不会超过船的最大运载重量。

 返回能在 days 天内将传送带上的所有包裹送达的船的最低运载能力。

  

 示例 1：

 输入：weights = [1,2,3,4,5,6,7,8,9,10], days = 5
 输出：15
 解释：
 船舶最低载重 15 就能够在 5 天内送达所有包裹，如下所示：
 第 1 天：1, 2, 3, 4, 5
 第 2 天：6, 7
 第 3 天：8
 第 4 天：9
 第 5 天：10

 请注意，货物必须按照给定的顺序装运，因此使用载重能力为 14 的船舶并将包装分成 (2, 3, 4, 5), (1, 6, 7), (8), (9), (10) 是不允许的。
 提示：
 1 <= days <= weights.length <= 5 * 104
 1 <= weights[i] <= 500

 来源：力扣（LeetCode）
 链接：https://leetcode.cn/problems/capacity-to-ship-packages-within-d-days
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */
class _1011_在D天内送达包裹的能力  {
    func shipWithinDays(_ weights: [Int], _ days: Int) -> Int {
        var left = 0;
        // 注意，right 是开区间，所以额外加一
        var right = 1;
        for weight in weights {
            left = max(left, weight)
            right = weight + right;
        }
        
        while left < right {
            let mid = left + (right - left) / 2
            let costDay = fx(weights, mid)
            if costDay == days {
                right = mid
            } else if costDay > days {
                left = mid + 1
            }  else if costDay < days {
                right = mid
            }
        }
        return left
    }
    
    func fx(_ weights:[Int], _ x: Int) -> Int{
        var days = 0
        var index = 0
        while index < weights.count {
            var cap = x
            while index < weights.count {
                if cap < weights[index] {
                    break;
                } else {
                    cap = cap - weights[index];
                }
                index = index + 1
            }
            days = days + 1
        }
        
        return days
    }
}
