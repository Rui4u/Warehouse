//
//  LGFileManager.swift
//  ImageZipSwfit
//
//  Created by sharui on 2021/2/5.
//

import Cocoa

struct SRFileManager {
    typealias FileManagerClosure = (String)->()
    static func enumPath(url : String) -> [String] {
        var pathLiast = [String]()
        let args = CommandTools.argsToDictionary()
        let extensionString = args["extension"] as? String ?? "png,jpg,jpeg"
        var extensitonList = extensionString.components(separatedBy: ",")
        extensitonList = Array<String>(Set(extensitonList)) // 去重
        subPath(url: url) { (path) in
            for ext in extensitonList {
                if path.extension.contains(ext) && !path.contains("yw_1222") {  //yw_1222为秘钥
                    pathLiast.append(path)
                }
            }
        }
        return pathLiast
    }
    
    static func subPath(url : String, closer:FileManagerClosure) {
        var isDirectory: ObjCBool = true;
        guard let subPaths = FileManager.default.subpaths(atPath: url) else {
            return
        }
        
        for path in subPaths {
            let fullPath = url + "/" + path
            if FileManager.default.fileExists(atPath: fullPath, isDirectory: &isDirectory) {
                if isDirectory.boolValue {
                } else {
                    closer(fullPath)
                }
            }
        }
    }
    
    static func fileSize(path:String) -> Int {
        guard let data = FileManager.default.contents(atPath: path) else {
            return 0
        }
        return data.count
    }

}


extension String {
    var `extension`: String {
        if let index = self.lastIndex(of: ".") {
            return String(self[index...])
        } else {
            return ""
        }
    }
}
