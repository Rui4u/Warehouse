//
//  ParsingModel.swift
//  ErrorAnalysis
//
//  Created by sharui on 2022/2/7.
//

import Foundation


struct ListItemDataSource : Hashable, Identifiable, CustomStringConvertible {
    
    var id: String
    var title: String
    var version: String
    var analyseDatas: ParsingResultModel? = nil
    var children: [ListItemDataSource] = [ListItemDataSource]()
    var index: Int = 0
    var isFile: Bool {
        get {
            return children.count > 0
        }
    }
    
    var description: String {
        if isFile {
            return "📁 \(version)"
        } else {
            return alertMsg() ?? title
        }
    }
    func importMsg() ->String? {
        if let str = alertMsg() {
            return String(str.split(separator: "\n").last ?? "")
        }
        return ""
    }
    
    func alertMsg() -> String?{
        guard let dict = JsonTools.dictionary(jsonString: analyseDatas?.orginJsonString) as? [String: Any] else {
            return ""
        }
        
        let alertInfo = dict["alert"] as? [String: String]
        return alertInfo?["alert_msg"]
    }
    
    
}

struct ParsingResultModel: Hashable,Identifiable {
    static func == (lhs: ParsingResultModel, rhs: ParsingResultModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id: String {
        return args.crashIdentifier
    }
    
    var args: Args
    /// 解析后的数据
    var parsingReuslt: Array<String>
    /// 单独解析的结果
    var onlyParsingReuslt: Array<String>
    /// 原始json数据  从h5传过来的
    var orginJsonString: String
    /// 原始解析后的json数据
    var orginParsingJsonString: String
    
    struct Args:Identifiable,Hashable {
        var crashIdentifier: String
        var version: String
        var id: String {
            return crashIdentifier
        }
    }
    
   
    
    static func creatModel(orginJsonString:String, orginParsingJsonString:String) ->ParsingResultModel? {
        guard let dict = JsonTools.dictionary(jsonString: orginParsingJsonString) else {
            return nil
        }
        guard let args = dict["args"] as? [String: String] else {
            return nil
        }
        guard let parsingResult = dict["parsingReuslt"] as? [String : Any] else {
            return nil
        }
        return ParsingResultModel(args: ParsingResultModel.Args(crashIdentifier: args["crashIdentifier"] ?? "", version: args["version"] ?? ""),
                                  parsingReuslt: parsingResult["parsings"] as? [String] ?? [String](),
                                  onlyParsingReuslt: parsingResult["parsingIndexReuslt"] as? [String] ?? [String](),
                                  orginJsonString: orginJsonString,
                                  orginParsingJsonString: orginParsingJsonString)
    }
}

struct JsonTools {
    static func dictionary(jsonString:String?) ->NSDictionary?{
        guard var s = jsonString else {
            return nil
        }
        s = s.removingPercentEncoding ?? ""
        
        let jsonData:Data = s.data(using: .utf8)!
        var dict: NSDictionary?
        do {
            dict = try JSONSerialization.jsonObject(with: jsonData, options: .topLevelDictionaryAssumed) as? NSDictionary
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        
        return dict
    }
}

struct ParsingRequestModel {
    var version: String
    var errorStr: String
    var buildVersion: String
    var jenkinsPathName: String
    var crashIdentifier: String
    var loadAddress:String
    
    func transformToDict() -> [String: String]{
        let dict = [
            "version":version,
            "errorStr":errorStr,
            "buildVersion":buildVersion,
            "jenkinsPathName":jenkinsPathName,
            "crashIdentifier":crashIdentifier,
            "loadAddress":loadAddress
        ]
        return dict
    }
}


