//
//  _155_最小栈.swift
//  算法练习
//
//  Created by 沙睿 on 2022/5/30.
//

import Foundation
class _155_最小栈 {
    public var stack:Array<Int>
    public var min:Array<Int>
    init() {
        stack  = Array()
        min =  Array()
    }
    
    func push(_ x: Int) {
        stack.append(x)
        if(min.count == 0 )
        {
            min.append(x);
        } else if (x < min.last!){
            min.append(x);
        } else {
            min.append(min.last!)
        }
    }
    
    func pop() {
        min.removeLast()
        stack.removeLast()
    }
    
    func top() -> Int {
        return stack.last!
    }
    
    func getMin() -> Int {
        return min.last!
    }
}


class MinStack2 {
    
    class Node {
        var val: Int
        var min: Int
        var next: Node?
        init(val: Int, min:Int, next:Node?) {
            self.val = val
            self.min = min
            self.next = next
        }
    }
    
    var header: Node?
    
    init() {
        
    }
    
    func push(_ val: Int) {
        var currentMin: Int
        if header == nil {
            currentMin = val
        }else {
            currentMin =  header!.val < val ? header!.val : val
        }
        
        let current = Node(val: val, min: currentMin, next: nil)
        let temp = header
        header = current
        current.next = temp
    }
    
    func pop() {
        header = header?.next
    }
    
    func top() -> Int {
        header!.val
    }
    
    func getMin() -> Int {
        header!.min
    }
}

