//
//  TechAidApp.swift
//  TechAid
//
//  Created by Era Aliu on 29.1.25.
//

import SwiftUI
import SwiftData

@main
struct TechAidApp: App {
    @StateObject private var authManager = AuthenticationManager()
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            User.self,
            Course.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            if authManager.isAuthenticated {
                MainTabView()
            } else {
                LoginView()
            }
        }
        .modelContainer(sharedModelContainer)
        .environmentObject(authManager)
    }
}
