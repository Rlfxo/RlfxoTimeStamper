//
//  RlfxoTimeStamperApp.swift
//  RlfxoTimeStamper
//
//  Created by 임길태 on 2021/12/15.
//

import SwiftUI

@main
struct RlfxoTimeStamperApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
