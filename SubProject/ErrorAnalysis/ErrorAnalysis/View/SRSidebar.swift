//
//  SRSidebar.swift
//  ErrorAnalysis
//
//  Created by sharui on 2022/10/10.
//

import Foundation
import SwiftUI
import CoreData

struct ListViewItem: View {
    var index: Int
    var description: String
    var mobile: String
    var osV: String
    var time:String
    var body: some View {
        HStack(alignment: .center) {
            Text("\(index + 1)").frame(width: 30).font(.caption2)
            VStack {
                HStack {
                    Text(description)
                        .fontWeight( .heavy)
                        .lineLimit(Int.max)
                    Spacer()
                }
                HStack {
                    Text(time)
                    Spacer()
                    Text(mobile)
                    Text(osV)
                }
            }
        }
    }
}


struct SRSidebar: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    /// 列表选择的数据
    @State var selected:ListItemDataSource?
    @State var listData: [ListItemDataSource] = [ListItemDataSource]()
    var viewModel = ParsingViewModel.shared
    
    
    var body: some View {
        List(selection: $selected) {
            ForEach(listData) { items in
                Section(header: Text("\(items.description)")) {
                    ForEach(items.children) { item in
                        NavigationLink(tag: item,selection: $selected) {
                            ParsingDetailsView(dataSource: item)
                                .navigationTitle(Text(item.description))
                        } label: {
                            let dict = JsonTools.dictionary(jsonString: item.analyseDatas?.orginJsonString) as? [String: Any]
                            let base = dict?["base"] as? [String: Any]
                            let osV = "iOS " + (base?["os_v"] as? String ?? "")
                            let mobile = base?["model"] as? String ?? ""
                            let time = base?["log_time"] as? Double ?? 0
                            ListViewItem(index: item.index, description: item.description, mobile: mobile, osV: osV, time: timeIntervalChangeToTimeStr(timeInterval: Double(time/1000)))
                                .frame(minWidth: 300)
                        }
                        .contextMenu {
                            VStack {
                                Button("删除") {
                                    print(item)
                                    deleteItem(item: item)
                                }
                            }
                        }
                   
                    }
                }
            }
        }.onReceive(ParsingViewModel.shared.$listData) { listData in
            self.listData = listData
        }.onReceive(ParsingViewModel.shared.$selected) { selected in
            self.selected = selected
        }
    }
    private func deleteItem(item:ListItemDataSource) {
        viewModel.deleteItemAllOperation(deleteItem: item)
    }
    
    
    //时间戳转成字符串
    func timeIntervalChangeToTimeStr(timeInterval:Double, _ dateFormat:String? = "yyyy-MM-dd HH:mm:ss") -> String {
        let date:Date = Date.init(timeIntervalSince1970: timeInterval)
        let formatter = DateFormatter.init()
        if dateFormat == nil {
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        }else{
            formatter.dateFormat = dateFormat
        }
        return formatter.string(from: date as Date)
    }
}
