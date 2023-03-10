//
//  ErrorAnalysisApp.swift
//  ErrorAnalysis
//
//  Created by sharui on 2022/2/6.
//

import SwiftUI

@main
struct ErrorAnalysisApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    let persistenceController = PersistenceController.shared
    let serverData = ServerData.shared
    var body: some Scene {
        WindowGroup {
            RootContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(serverData)
                .frame(minWidth: 1300, maxWidth: .infinity, minHeight: 800, maxHeight: .infinity, alignment: .center)
        }
        .commands {
            CommandGroup(replacing: CommandGroupPlacement.newItem) {
                
            }
        }
    }
}

