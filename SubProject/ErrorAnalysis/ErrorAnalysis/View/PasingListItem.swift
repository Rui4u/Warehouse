//
//  PasingLeftListViews.swift
//  ErrorAnalysis
//
//  Created by sharui on 2022/2/10.
//

import SwiftUI

struct PasingListItem: View {
    var title: String
    var isHeavy: Bool
    var isFolder: Bool
    var time: Double = 0
    var os: String = ""
    var mobile: String = ""
    var index: Int = 0
    
    var body: some View {
       Text("")
//        HStack {
//            if !isFolder {
//                Text("\(index)")
//                    .fontWeight(.heavy)
//            }
//            
//            VStack(alignment: .leading) {
//                Text(title)
//                    .fontWeight(isHeavy ? .heavy : .regular)
//                    .lineLimit(3)
//                
//                if !isFolder {
//                    HStack {
//                        Text(timeIntervalChangeToTimeStr(timeInterval: Double(time)))
//                        Spacer()
//                        Text(mobile)
//                        HStack {
//                            Spacer()
//                            Text(os)
//                        }.frame(width: 80)
//                    }
//                }
//            }
//        }
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


