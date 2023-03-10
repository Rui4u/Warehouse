//
//  ParsingDetailsView.swift
//  ErrorAnalysis
//
//  Created by sharui on 2022/2/7.
//

import SwiftUI

struct ParsingDetailsViewStackList: View {
    var dataSource : [String]
    var onlyParsingDataSource :[String]
    var orginDataSource: String
    var importantError: String
    @State private var multiSelection = Set<String>()
    @State private var multiSelectionOrgin = Set<Int>()
    var i = 0
    var body: some View {
        HStack {
            List(selection: $multiSelection) {
                HStack {
                    Text("错误堆栈").font(.largeTitle)
                    Spacer()
                    Text(importantError).fontWeight(.bold)
                }
                ForEach(dataSource, id:\.self) { item in
                    ParsingDetailsViewItem(text: item, isParsingData:onlyParsingDataSource.contains(item))
                        .contextMenu {
                            VStack {
                                Button("复制") {
                                    print(multiSelection)
                                    copyToClipBoard(textToCopy: multiSelection)
                                }
                            }
                        }
                }
               
            }.listStyle(.inset)
            List(selection: $multiSelectionOrgin) {
                HStack {
                    Text("原始数据").font(.largeTitle)
                    Spacer()
                }
                let dataSource = OrginDataTools.resionArray(orginDataSource)
                ForEach(0..<dataSource.count) { index in
                    let item = dataSource[index]
                    ParsingDetailsViewItem(text: item, isParsingData:onlyParsingDataSource.contains(item))
                        .contextMenu {
                            VStack {
                                Button("复制") {
                                    print(multiSelectionOrgin)
                                    
                                    let copy = multiSelectionOrgin.map { i in
                                        return dataSource[i]
                                    }
                                    copyToClipBoard(textToCopy: Set(copy))
                                }
                            }
                        }
                }
            }.listStyle(.inset)
        }
    }
    
    func copyToClipBoard(textToCopy: Set<String>) {
        let pasteBoard = NSPasteboard.general
        pasteBoard.clearContents()
        let a = Array(textToCopy).filter{$0.count > 2}.sorted(by: { s1, s2 in
            let s1sub =  s1.prefix(upTo:s1.index(s1.startIndex, offsetBy: 2)).replacingOccurrences(of: " ", with: "")
            let s2sub =  s2.prefix(upTo: s2.index(s2.startIndex, offsetBy: 2)).replacingOccurrences(of: " ", with: "")
            
            let s1Int = Int(s1sub) ?? 0
            let s2Int = Int(s2sub) ?? 0
            print(s1Int)
            print(s2Int)
            return s1Int < s2Int
        }).joined(separator: "\n")
        pasteBoard.setString(a , forType: .string)
    }
}

struct ParsingDetailsView: View {
    var dataSource: ListItemDataSource
    @State private var multiSelection = Set<String>()
    var body: some View {

        VStack {

            if let alertMsg = dataSource.alertMsg() {
                ErrorInfo(error: alertMsg)
            }
            
            if let analyseData = dataSource.analyseDatas {
                ParsingDetailsViewStackList(dataSource: analyseData.parsingReuslt, onlyParsingDataSource: analyseData.onlyParsingReuslt,orginDataSource: analyseData.orginJsonString,importantError: dataSource.importMsg() ?? "")
            }
            
        }
    }
}


struct ErrorInfo: View {
    var error: String
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            HStack {
                Text("摘要").font(.largeTitle)
                Spacer()
            }
            Text(error)
        }
        .padding()
        
    }
}

struct ParsingDetailsViewItem: View {
    var text: String
    var isParsingData: Bool
    var body: some View {
        Text(text)
            .fontWeight(!isParsingData ? .regular : .heavy)
    }
}

//struct ErrorInfo_Previews: PreviewProvider {
//    static var previews: some View {
//        ErrorInfo(error: "胜多负少的发送到发啥的发送到发送到发送到防守打法\n胜多负少的发送到发啥的发送到发送到发送到防守打法\n胜多负少的发送到发啥的发送到发送到发送到防守打法\n")
//    }
//}
//
//struct ParsingDetailsViewStackList_Previews: PreviewProvider {
//    static var previews: some View {
//        ParsingDetailsViewStackList(dataSource: ["12312312321321"], onlyParsingDataSource:["12312312321321"] ,orginDataSource: "12312312321321",importantError: "12312312321321")
//    }
//}



