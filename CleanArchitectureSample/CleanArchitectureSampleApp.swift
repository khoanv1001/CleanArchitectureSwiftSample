//
//  CleanArchitectureSampleApp.swift
//  CleanArchitectureSample
//
//  Created by Nguyen Viet Khoa on 03/04/2024.
//

import SwiftUI

@main
struct CleanArchitectureSampleApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
