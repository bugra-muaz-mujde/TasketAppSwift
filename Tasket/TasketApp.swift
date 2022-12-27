//
//  TasketApp.swift
//  Tasket
//
//  Created by queque on 26.12.2022.
//

import SwiftUI

@main
struct TasketApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            TasketListView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
