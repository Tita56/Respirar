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
    var body: some Scene {
        WindowGroup {
            // 🧪 Para desarrollo: usa MainTabViewDebug
            // 📱 Para producción: usa MainTabView
            #if DEBUG
            MainTabViewDebug()
            #else
            MainTabView()
            #endif
        }
        .modelContainer(for: BreathingSession.self)
    }
}
