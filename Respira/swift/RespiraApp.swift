//
//  RespiraApp.swift
//  Respira
//
//  Created by Amada Hernández Borges on 6/3/26.
//

import SwiftUI
import SwiftData

@main
struct RespiraApp: App {
    // Model Container local (sin App Group para widget)
    let modelContainer: ModelContainer = {
        let schema = Schema([
            BreathingSession.self,
        ])
        
        let modelConfiguration = ModelConfiguration(
            schema: schema,
            cloudKitDatabase: .none
        )

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("No se pudo crear ModelContainer: \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
        }
        .modelContainer(modelContainer)
    }
}
