//
//  _22_括号生成.swift
//  算法练习
//
//  Created by sharui on 2022/6/22.
//

import Foundation
class _22_括号生成 {
    func generateParenthesis(_ n: Int) -> [String] {
        var list = [String]()
        generateParenthesisHelp(list: &list, str: "", left: 0, right: 0, n: n)
        return list
    }
    
    func generateParenthesisHelp(list: inout [String],str: String, left: Int, right:Int, n:Int) {
        guard left >= right, left <= n, right <= n else {
            return
        }
        if left == right {
            list.append(str) //剪枝
        }
        generateParenthesisHelp(list: &list, str: str + "(", left: left + 1, right: right, n: n)
        generateParenthesisHelp(list: &list, str: str + ")", left: left, right: right + 1, n: n)
    }
}
