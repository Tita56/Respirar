//
//  RespiraApp.swift
//  Respira
//
//  Created by Amada Hernández Borges on 6/3/26.
//

import SwiftUI
import SwiftData
import Foundation

@main
struct RespiraApp: App {
    // Model Container compartido con el widget
    let sharedModelContainer: ModelContainer = {
        let schema = Schema([
            BreathingSession.self,
        ])
        
        let modelConfiguration = ModelConfiguration(
            schema: schema,
            url: AppGroup.containerURL.appendingPathComponent("Respira.sqlite"),
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
            // 🧪 Para desarrollo: usa MainTabViewDebug
            // 📱 Para producción: usa MainTabView
            #if DEBUG
            MainTabView()
            #else
            MainTabView()
            #endif
        }
        .modelContainer(sharedModelContainer)
    }
}
