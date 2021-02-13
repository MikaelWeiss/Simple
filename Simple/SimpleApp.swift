//
//  SimpleApp.swift
//  Simple
//
//  Created by Mikael Weiss on 2/12/21.
//

import SwiftUI

@main
struct SimpleApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
