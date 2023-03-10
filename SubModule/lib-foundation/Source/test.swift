//
//  DevsNotiDataHelper.swift
//  ErrorAnalysis
//
//  Created by sharui on 2022/10/11.
//


import SQLite


struct DB {
    static var manager: DB?
    
    static func shared(path: String) -> DB {
        guard let manager = manager else {
            manager = DB(fileName:path)
            return manager!
        }
        return manager
    }
    
    static let path = NSSearchPathForDirectoriesInDomains(
        .applicationSupportDirectory, .userDomainMask, true
    ).first!
    let BBDB: Connection?
    var fileName: String
    private init(fileName: String) {
        self.fileName = fileName
        do {
            print(DB.path)
            BBDB = try Connection("\(DB.path)/\(fileName)")
            
        } catch {
            BBDB = nil
        }
        /// Swift 类型和 SQLite 类型对标如下：
        /// Int64 = INTEGER
        /// Double = REAL
        /// String = TEXT
        /// nil = NULL
        /// SQLite.Blob = BLOB
        
    }
    
    // 创建表
    func cTbs() throws {
        do {
            let dataSource = [TableCloumn(expresion: Expression<String>("title"), defaultValaue: "")]
//            try DevsNotiDataHelper.createTable(columns: dataSource)
        } catch {
            throw DBError.connectionErr
        }
    }
    
}

enum DBError: Error {
    case connectionErr, insertErr, deleteErr, searchErr, updateErr, nilInData
}


protocol DataHelperProtocol {

    associatedtype T
    
    static var table : Table { get }
    static var dbPath: String { get }
    static func createTable(columns: [TableCloumn<some Value>]) throws -> Void
    static func insert(i: T) throws -> Int64
    static func delete(i: T) throws -> Void
    static func findAll() throws -> [T]?
    
}

struct TableCloumn<T: Value> {
    var expresion: Expression<T>
    var defaultValaue: T
}

//extension DataHelperProtocol {
//    typealias V =  Value
//    static func createTable(columns: [TableCloumn<some Value>]) throws -> Void {
//
//        guard let db = DB.shared(path: dbPath).BBDB else {
//            throw DBError.connectionErr
//        }
//        do {
//
//            let _ = try db.run(table.create(ifNotExists: true) { t in
//                for cloumn in columns {
//                    t.column(cloumn.expresion, defaultValue: cloumn.defaultValaue)
//                }
//            })
//        } catch _ {
//            throw DBError.connectionErr
//        }
//    }
//
//    static func insert(i: DBCrashLog) throws -> Int64 {
//        guard let db = DB.shared(path: dbPath).BBDB else {
//            throw DBError.connectionErr
//        }
//
//        let data =
//        table.insert()
//        let insert = table.insert(identifier <- i.identifier, timestamp <- i.timestamp, analysisCrashThread <- i.analysisCrashThread, allErrorInfo <- i.allErrorInfo)
//        do {
//            let rowId = try db.run(insert)
//            guard rowId > 0 else {
//                throw DBError.insertErr
//            }
//            return rowId
//        } catch {
//            throw DBError.insertErr
//        }
//    }
//}
//
//// MARK: 崩溃日志
//typealias DBCrashLog = (
//    identifier: String,
//    timestamp: Int64,
//    analysisCrashThread: String,
//    allErrorInfo: String
//)
//
//struct DevsNotiDataHelper: DataHelperProtocol {
//
//    static var dbPath: String = "source.sqlite3"
//
//    static let table = Table("devsNoti")
//    static let identifier = Expression<String>("identifier")
//    static let timestamp = Expression<Int64>("timestamp")
//    static let analysisCrashThread = Expression<String>("analysisCrashThread")
//    static let allErrorInfo = Expression<String>("allErrorInfo")
//    typealias T = DBCrashLog
//
//
//    static func insert(i: DBCrashLog) throws -> Int64 {
//        guard let db = DB.shared(path: dbPath).BBDB else {
//            throw DBError.connectionErr
//        }
//        let insert = table.insert(identifier <- i.identifier, timestamp <- i.timestamp, analysisCrashThread <- i.analysisCrashThread, allErrorInfo <- i.allErrorInfo)
//        do {
//            let rowId = try db.run(insert)
//            guard rowId > 0 else {
//                throw DBError.insertErr
//            }
//            return rowId
//        } catch {
//            throw DBError.insertErr
//        }
//    } // end insert
//
//    static func delete(i: DBCrashLog) throws {
//        guard let db = DB.shared(path: dbPath).BBDB else {
//            throw DBError.connectionErr
//        }
//        let query = table.filter(identifier == i.identifier)
//        do {
//            let tmp = try db.run(query.delete())
//            guard tmp == 1 else {
//                throw DBError.deleteErr
//            }
//        } catch {
//            throw DBError.deleteErr
//        }
//    } // end delete
//
//    static func find(id: String) throws -> DBCrashLog? {
//        guard let db = DB.shared(path: dbPath).BBDB else {
//            throw DBError.connectionErr
//        }
//        let query = table.filter(identifier == id)
//        let items = try db.prepare(query)
//        for i in items {
//            return DBCrashLog(identifier:i[identifier], timestamp: i[timestamp], analysisCrashThread: i[analysisCrashThread], allErrorInfo:i[allErrorInfo])
//        }
//        return nil
//    } // end find
//
//    static func update(i: DBCrashLog) throws {
//        guard let db = DB.shared(path: dbPath).BBDB else {
//            throw DBError.connectionErr
//        }
//        let query = table.filter(timestamp == i.timestamp)
//        do {
//            if try db.run(query.update(timestamp <- i.timestamp, analysisCrashThread <- i.analysisCrashThread, allErrorInfo <- i.allErrorInfo)) > 0 {
//
//            } else {
//                throw DBError.updateErr
//            }
//        } catch {
//            throw DBError.updateErr
//        }
//    } // end update
//
//    static func findAll() throws -> [DBCrashLog]? {
//        guard let db = DB.shared(path: dbPath).BBDB else {
//            throw DBError.connectionErr
//        }
//        var arr = [DBCrashLog]()
//        let items = try db.prepare(table)
//        for i in items {
//            arr.append(DBCrashLog(identifier: i[identifier],
//                                  timestamp: i[timestamp],
//                                  analysisCrashThread: i[analysisCrashThread],
//                                  allErrorInfo:i[allErrorInfo]))
//        }
//        return arr
//    } // end find all
//
//}


//// MARK: 崩溃日志
//typealias ServerIP = (
//    identifier:Int64,
//    ip: String,
//    selected: Bool,
//    enableChange: Bool
//)
//
//struct ServerIPsDataHelper: DataHelperProtocol {
//    static let table = Table("serversIP")
//    static let ip = Expression<String>("ip")
//    static let selected = Expression<Bool>("selected")
//    static let identifier = Expression<Int64>("identifier")
//    static let enableChange = Expression<Bool>("enableChange")
//
//    typealias T = ServerIP
//
//    static func createTable() throws {
//        guard let db = DB.shared.BBDB else {
//            throw DBError.connectionErr
//        }
//        do {
//            let _ = try db.run(table.create(ifNotExists: true) { t in
//                t.column(identifier, defaultValue: 0)
//                t.column(ip, defaultValue: "")
//                t.column(selected, defaultValue: false)
//                t.column(enableChange, defaultValue: false)
//            })
//        } catch _ {
//            throw DBError.connectionErr
//        }
//    } // end createTable
//
//    static func insert(i: ServerIP) throws -> Int64 {
//        guard let db = DB.shared.BBDB else {
//            throw DBError.connectionErr
//        }
//        let insert = table.insert(identifier <- i.identifier, ip <- i.ip, selected <- i.selected, enableChange <- i.enableChange)
//        do {
//            let rowId = try db.run(insert)
//            guard rowId > 0 else {
//                throw DBError.insertErr
//            }
//            return rowId
//        } catch {
//            throw DBError.insertErr
//        }
//    } // end insert
//
//    static func delete(i: ServerIP) throws {
//        guard let db = DB.shared.BBDB else {
//            throw DBError.connectionErr
//        }
//        let query = table.filter(identifier == i.identifier)
//        do {
//            let tmp = try db.run(query.delete())
//            guard tmp == 1 else {
//                throw DBError.deleteErr
//            }
//        } catch {
//            throw DBError.deleteErr
//        }
//    } // end delete
//
//    static func find(id: Int64) throws -> T? {
//        guard let db = DB.shared.BBDB else {
//            throw DBError.connectionErr
//        }
//        let query = table.filter(identifier == id)
//        let items = try db.prepare(query)
//        for i in items {
//            return ServerIP(identifier:i[identifier], ip: i[ip], selected: i[selected],enableChange: i[enableChange])
//        }
//        return nil
//    } // end find
//
//    static func update(i: T) throws {
//        guard let db = DB.shared.BBDB else {
//            throw DBError.connectionErr
//        }
//        let query = table.filter(identifier == i.identifier)
//        do {
//            if try db.run(query.update(identifier <- i.identifier, ip <- i.ip, selected <- i.selected, enableChange <- i.enableChange)) > 0 {
//
//            } else {
//                throw DBError.updateErr
//            }
//        } catch {
//            throw DBError.updateErr
//        }
//    } // end update
//
//    static func findAll() throws -> [T]? {
//        guard let db = DB.shared.BBDB else {
//            throw DBError.connectionErr
//        }
//        var arr = [T]()
//        let items = try db.prepare(table)
//        for i in items {
//            arr.append(ServerIP(identifier:i[identifier], ip: i[ip], selected: i[selected], enableChange: i[enableChange]))
//        }
//        return arr
//    } // end find all
//
//}
