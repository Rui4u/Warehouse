//
//  CommandArgsTools.swift
//  ImageZipSwfit
//
//  Created by sharui on 2021/2/5.
//

import Foundation

struct CommandTools {
    static func argsToDictionary() -> Dictionary<String,Any> {
        var argv = CommandLine.arguments
        argv.removeFirst()
        
        var argvDict = Dictionary<String,Any>()
        var tempKey: String?
        for (index, arg) in argv.enumerated() {
            if index % 2 == 0 {
                var temp = arg
                temp.removeFirst()
                tempKey = temp
            }else {
                if let key = tempKey {
                    argvDict[key] = arg
                }
            }
        } 
        return argvDict
    }
    
    static func input(inputs:String?) -> String? {
        if var input = inputs {
            let subStr = input.index(input.endIndex, offsetBy: -1)
            let lastStr = String(input[subStr..<input.endIndex])
            if lastStr == "\n" {
                let subStr = input.index(input.endIndex, offsetBy: -2)
                input = String(input[...subStr])  //去掉最后一个\n
                input = input.trimmingCharacters(in: .whitespaces)
                return input
            }else {
                input = input.trimmingCharacters(in: .whitespaces)
                return input
            }
//            /Users/lagou/Desktop/教育购买
        }
        return nil
    }
    
    static func output(_ output: String) -> Void {
        print(output)
    }
}


