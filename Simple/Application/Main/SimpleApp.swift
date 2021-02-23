//
//  SimpleApp.swift
//  Simple
//
//  Created by Mikael Weiss on 2/12/21.
//

import SwiftUI

@main
struct SimpleApp: App {
    @State private var selectedTab = Tabs.tasksOverview
    
    enum Tabs: Hashable {
        case tasksOverview
        case nextUp
    }

    var body: some Scene {
        WindowGroup {
            TabView(selection: $selectedTab) {
                NavigationView {
                    TasksOverview.Scene().view
                }
                    .tabItem {
                        Image(systemName: "pencil.circle.fill")
                        Text("Overview")
                    }.tag(Tabs.tasksOverview)
                Text("Tab Content 2")
                    .tabItem {
                        Image(systemName: "line.horizontal.3.circle")
                        Text("Next up")
                    }.tag(Tabs.nextUp)
            }
        }
    }
}
