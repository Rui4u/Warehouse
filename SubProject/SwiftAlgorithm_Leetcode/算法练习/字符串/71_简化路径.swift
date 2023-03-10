//
//  71_简化路径.swift
//  算法练习
//
//  Created by sharui on 2022/6/22.
//

import Foundation
class _71_简化路径 {
    func simplifyPath(_ path: String) -> String {
        let list = path.components(separatedBy: "/")
        var stack = [String]();
        print(list)
        for s in list {
            if s == ".." {
                if stack.count > 0 {
                    stack.removeLast();
                }
            } else if s != "." && s.count > 0 {
                stack.append(s);
            }
        }
        return "/" + stack.joined(separator:"/")
    }
}
