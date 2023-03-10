//
//  _200_岛屿数量.swift
//  算法练习
//
//  Created by sharui on 2022/6/17.
//

import Foundation

class _200_岛屿数量 {
     var record : [[Bool]]!
    var finded: [[Bool]]!
    var maxValue = 0
    
    func numIslands(_ grid: [[Character]]) -> Int {
        if grid.count == 0 {
            return 0
        }
        record = Array(repeating: Array(repeating: false, count: grid.first!.count), count: grid.count)
        finded = Array(repeating: Array(repeating: false, count: grid.first!.count), count: grid.count)
        
        for i in 0..<grid.count {
            for j in 0..<grid[i].count {
                let current = grid[i][j]
                if current == "1" {
                    if !record[i][j] {
                        find(i:i,j:j, grid:grid)
                        maxValue = maxValue + 1
                    }
                }
            }
        }
        return maxValue
    }


    func find(i: Int, j: Int, grid:[[Character]]) {
        guard i >= 0 && j >= 0 else {
            return
        }
        guard i < grid.count else {
            return
        }
        guard j < grid[i].count else {
            return
        }

        
        if grid[i][j] == "1" {
            record[i][j] = true
        } else {
            return
        }
        
        if finded[i][j] {
            return
        }
        finded[i][j] = true
        find(i: i, j:j + 1, grid:grid)
        find(i: i, j:j - 1, grid:grid)
        find(i: i + 1, j:j, grid:grid)
        find(i: i - 1, j:j, grid:grid)
    }
}
