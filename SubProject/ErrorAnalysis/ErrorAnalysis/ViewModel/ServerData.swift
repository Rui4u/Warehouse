//
//  ServerData.swift
//  ErrorAnalysis
//
//  Created by sharui on 2022/10/11.
//

import Foundation
final class ServerData: ObservableObject {
    
    static let shared = ServerData()
    private init() {
        
    }
    
    @Published var servers: [ChangeServerModel] = [ChangeServerModel]()
    
    func updateFromDB() {
        var list = [ChangeServerModel]()
        if let dbs =  try? ServerIPsDataHelper.findAll() {
            for db in dbs {
                list.append(ChangeServerModel(ip: db.ip, selected: db.selected, id: db.identifier, enableChange: db.enableChange))
            }
        }
        servers = list
    }
    func saveToDB() {
        for server in servers {
            addToDB(item: server)
        }
    }
    
    
    private func addToDB(item: ChangeServerModel) {
        if let _ = try? ServerIPsDataHelper.find(id: item.id) {
            let _ =  try? ServerIPsDataHelper.update(i:ServerIP(identifier:item.id,ip:item.ip, selected:item.selected, enableChange: item.enableChange))
        } else {
            let _ = try? ServerIPsDataHelper.insert(i: ServerIP(identifier:item.id,ip:item.ip, selected:item.selected, enableChange: item.enableChange))
        }
    }
    
    private func deleteToDB(item: ChangeServerModel) {
        if let db = try? ServerIPsDataHelper.find(id: item.id) {
            let _ =  try? ServerIPsDataHelper.delete(i:db)
        }
    }
    
    func addEmptyItem() {
        guard let lastServer = servers.last else {
            let new = ChangeServerModel(ip: "", selected: false, id: Date().milliStamp, enableChange: true)
            addToDB(item: new)
            servers.append(new)
            return
        }
        
        if lastServer.ip.count > 0 {
            let new = ChangeServerModel(ip: "", selected: false, id: Date().milliStamp, enableChange: true)
            addToDB(item: new)
            servers.append(new)
        }
    }
    
    func delete(item: ChangeServerModel) {
        if item.enableChange {
            deleteToDB(item: item)
            servers.removeAll(where: {$0.id == item.id})
        }
        if servers.count == 1 {
            servers[0].selected = true
            addToDB(item: servers[0])
        }
    }
    
    func addDefauleItem() {
        updateFromDB()
        if servers.count == 0 {
            let new = ChangeServerModel(ip: "http://10.71.6.210:4000", selected: true, id: Date().milliStamp, enableChange: false)
            addToDB(item: new)
            servers.append(new)
            
        }
    }
    
}

struct ChangeServerModel: Identifiable,Hashable {
    
    var ip: String
    var selected: Bool
    var id: Int64
    var enableChange: Bool
}
