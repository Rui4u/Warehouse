//
//  AppDelegate.swift
//  ErrorAnalysis
//
//  Created by sharui on 2022/2/7.
//

import Foundation
import AppKit
import SQLite

class AppDelegate: NSObject, NSApplicationDelegate {
    
    func applicationWillFinishLaunching(_ notification: Notification) {
        NSAppleEventManager.shared() .setEventHandler(self, andSelector: #selector(handleURLEvent(theEvent:willEvent:)), forEventClass: AEEventClass(kInternetEventClass), andEventID: AEEventID(kAEGetURL))
        let db = DB.shared
        try? db.cTbs() // 创建表
        ServerData.shared.addDefauleItem()
   
        
    }
    
    @objc func handleURLEvent(theEvent: NSAppleEventDescriptor, willEvent:NSAppleEventDescriptor) {
        var values = theEvent.paramDescriptor(forKeyword: keyDirectObject)?.stringValue ?? ""
        ParsingViewModel.shared.schemeUrl = values
        values = values.replacingOccurrences(of: "lgerroranalysis://?", with: "")
        values =  values.removingPercentEncoding ?? ""
        ParsingViewModel.shared.orginJsonString = values;
    }
}
