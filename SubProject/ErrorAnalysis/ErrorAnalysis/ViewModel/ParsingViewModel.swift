//
//  ParsingViewModel.swift
//  ErrorAnalysis
//
//  Created by sharui on 2022/2/8.
//

import Foundation
import Combine

class OrginDataTools {
    static func resionArray(_ orginJsonString: String) -> [String] {
        guard let dict =  JsonTools.dictionary(jsonString: orginJsonString) else {
            return [String]()
        }
        
        let stack = dict["stack"] as? String ?? ""

        let stackArray = stack.components(separatedBy: "\n")
        return stackArray
    }
}


class ParsingViewModel {
    
    static var shared = ParsingViewModel()
    
    /// 原始json数据
    var orginJsonString: String? {
        didSet {
            guard let dict =  JsonTools.dictionary(jsonString: orginJsonString ?? "") else {
                return
            }
            guard let buildInfo = dict["build_info"] as? [String: String] else {
                return
            }
            guard let baseInfo = dict["base"] as? [String: Any] else {
                return
            }
            
            let app_v = baseInfo["app_v"] as? String ?? ""
            let stack = dict["stack"] as? String ?? ""
            let jenkins_path_name = buildInfo["jenkins_path_name"] ?? ""
            let build_version = buildInfo["build_version"] ?? ""
            
            var reson = stack
            let stackArray = stack.components(separatedBy: "\n")
            
            if stack.contains("Exception Type")  {
                reson = ""
                var temp = stackArray[3].components(separatedBy: ":").last ?? "0"
                let crashedNum = (temp as! NSString ).intValue
                let crashedNumInfo = "Thread \(crashedNum) Crashed:"
                if let crashedIndex = stackArray.firstIndex(of: crashedNumInfo) {
                    for index in crashedIndex+1..<stackArray.count {
                        if stackArray[index] != "" {
                            reson.append(contentsOf: stackArray[index])
                            reson.append(contentsOf: "\n")
                        } else {
                            break;
                        }
                    }
                }
            }
            
            let binaryArray = stackArray.filter { item in
                item.contains("Binary Images:")
            }
            
            var binaryIndex : Int?
            if let binaryTitleName =  binaryArray.first {
                binaryIndex = stackArray.firstIndex(of:binaryTitleName)
            }
            // 如果找到了
            
            var loadAddress: String?
            if let binaryIndex = binaryIndex {
                if binaryIndex + 1 < stackArray.count {
                    let str = stackArray[binaryIndex + 1]
                    loadAddress = str.components(separatedBy: "-").first?.replacingOccurrences(of: " ", with: "")
                }
            }
            
         
            print(reson)
            
            guard let alertDict = dict["alert"] as? [String: Any] else {
                return
            }
            guard let crashIdentifier = alertDict["crashIdentifier"] as? String else {
                return
            }
            if let item = findItem(id: crashIdentifier) {
                selected = item
                return
            }
            
            let requestResult = ParsingRequestModel(version: app_v, errorStr: reson, buildVersion: build_version, jenkinsPathName: jenkins_path_name, crashIdentifier: crashIdentifier,loadAddress: loadAddress ?? "")
            
            RequestManager().request(requestModel: requestResult, orginJsonString: orginJsonString ?? "") { requestData, requestResult in
                DispatchQueue.main.async {
                    self.resultModel = requestResult
                }
            }
        }
    }
    
    /// 正在刷新
    @Published var parsing: Bool = false
    /// 列表选择的数据
    @Published var selected:ListItemDataSource?
    
    /// 列表数据
    private var privateListData: [ListItemDataSource] = [ListItemDataSource]()
    /// 数据更新后推送列表数据
    @Published var listData: [ListItemDataSource] = [ListItemDataSource]()
    /// 请求后的结果
    @Published var resultModel: ParsingResultModel?
    
    @Published var schemeUrl: String = ""
    
    func listData(reload: Bool = false) -> [ListItemDataSource] {
        if privateListData.count != 0 {
            return privateListData
        }
        
        listDataMemoryFromDB()
        
        return privateListData
    }
    
    func listDataMemoryFromDB() {
        var result = [ListItemDataSource]()
        if let dbs = try? DevsNotiDataHelper.findAll() {
            for db in dbs {
                if let model = ParsingResultModel.creatModel(orginJsonString: db.allErrorInfo, orginParsingJsonString: db.analysisCrashThread) {
                    addItemToMomery(targetList: &result, model: model)
                }
            }
        }
        
        privateListData = result
    }

    ///MARK: - 选中相关
    
    func findItem(id:String) -> ListItemDataSource? {
        
        for item in privateListData {
            let newList = item.children.filter({$0.id == id})
            if newList.count > 0 {
                return newList.first
            }
        }
        return nil
    }
    
    func findSelectedItem(item: ParsingResultModel) {
    
        var selectedItem :ListItemDataSource? = nil
        for i in listData {
            for j in i.children {
                if j.id == item.id {
                    selectedItem = j
                }
            }
        }
        
        if let selectedItem = selectedItem {
            selected = selectedItem
        }
    }
    
    
    ///MARK: - 添加删除相关
    
    func addItemAllOperation(addItem: ParsingResultModel) {
        addItemToDB(addItem: addItem)
        addItemToMomery(item:addItem)
        listData = listData()
        findSelectedItem(item: addItem)
    }
    
    func addItemToMomery(item:ParsingResultModel) {
        addItemToMomery(targetList: &self.privateListData, model: item)
    }
    
    private func addItemToMomery(targetList result: inout [ListItemDataSource], model:ParsingResultModel) {
        
        
        var source =  ListItemDataSource(id:model.args.crashIdentifier,
                                         title: "title1",
                                         version: model.args.version,
                                         analyseDatas: model)
        if result.filter({$0.version == model.args.version}).count > 0 { // 有相同版本的 在版本内叠加
            if let index = result.firstIndex(where: { listItemDataSource in
                return listItemDataSource.version == model.args.version
            }) {
                var list = result[index].children
                source.index = list.count // 设置角标
                if list.filter({$0.id == source.id}).count == 0{ // 如果没有的时候再添加
                    list.append(source)
                    result[index].children = list
                }
            }
        } else {// 没有相同版本创建文件夹后的直接加入
            result.append(ListItemDataSource(id:model.args.crashIdentifier + "father",
                                             title: "title2",
                                             version: model.args.version,
                                             children: [source]))
        }
        
    }
    
    
    func addItemToDB(addItem: ParsingResultModel)  {
        _ = try?
        DevsNotiDataHelper.insert(i:DBCrashLog(
            identifier: addItem.id,
            timestamp: Date().milliStamp,
            analysisCrashThread:addItem.orginParsingJsonString,
            allErrorInfo: addItem.orginJsonString)
        )
        addItemToMomery(targetList: &privateListData, model: addItem)
    }
    
    let itemFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        return formatter
    }()
    
    
    func deleteItemAllOperation(deleteItem: ListItemDataSource) {
        deleteItemToDB(deleteItem: deleteItem)
        deleteItemToMemnory(deleteItem:deleteItem)
        listData = listData()
    }
    
    func deleteItemToMemnory(deleteItem:ListItemDataSource) {
        
        if privateListData.count == 0 {
            return
        }
        
        for index in 0..<privateListData.count {
            privateListData[index].children = privateListData[index].children.filter({$0.id != deleteItem.id})
        }
    }
    
    
    func deleteItemToDB(deleteItem:ListItemDataSource) {
        if let db = try? DevsNotiDataHelper.find(id: deleteItem.id) {
            try? DevsNotiDataHelper.delete(i: db)
        }
    }

}


extension Date {
    /// 获取当前 秒级 时间戳 - 10位
    var timeStamp : Int64 {
        let timeInterval: TimeInterval = self.timeIntervalSince1970
        let timeStamp = Int64(timeInterval)
        return timeStamp
    }
    /// 获取当前 毫秒级 时间戳 - 13位
    var milliStamp : Int64 {
        let timeInterval: TimeInterval = self.timeIntervalSince1970
        let millisecond = CLongLong(round(timeInterval*1000))
        return millisecond
    }
}
