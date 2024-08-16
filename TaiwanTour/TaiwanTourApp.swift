//
//  TaiwanTourApp.swift
//  TaiwanTour
//
//  Created by BBOB on 2024/8/16.
//

import SwiftUI

@main
struct TaiwanTourApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
