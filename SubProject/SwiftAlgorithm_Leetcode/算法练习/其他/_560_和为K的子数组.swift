//
//  _560_和为K的子数组.swift
//  算法练习
//
//  Created by sharui on 2022/5/5.
//

import Foundation
class _560_和为K的子数组 {
    func subarraySum(_ nums: [Int], _ k: Int) -> Int {
        var pre =  Array(repeating: 0, count: nums.count)
        var map = [Int:Int]()
        for index in 0..<nums.count {
            let preNum = index == 0 ? 0 : pre[index - 1]
            pre[index] =  preNum + nums[index]
        }
        
        map[0] = 1
        var count = 0
        for index in 0..<pre.count {
            let key = pre[index] - k;
            if map.keys.contains(key) {
                count = count + (map[key] ?? 0)
            }
            map[pre[index]] = (map[pre[index]] ?? 0 ) + 1
        }
        return count
    }
}


class _560_和为K的子数组2 {
    func subarraySum(_ nums: [Int], _ k: Int) -> Int {
        var count = 0, pre = 0;
        var mp = [Int:Int]()
        mp[0] = 1
        for i in 0..<nums.count {
            pre += nums[i];
            if (mp.keys.contains(pre - k)) {
                count = count + (mp[pre - k] ?? 0) ;
            }
            mp[pre] = (mp[pre] ?? 0) + 1
        }
        return count;
    }
}

