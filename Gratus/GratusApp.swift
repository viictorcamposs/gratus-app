//
//  GratusApp.swift
//  Gratus
//
//  Created by Victor Campos on 27/10/23.
//

import SwiftUI

@main
struct GratusApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
