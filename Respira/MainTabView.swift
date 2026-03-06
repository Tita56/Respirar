//
//  MainTabView.swift
//  Respira
//
//  Created by Amada Hernández Borges on 3/8/26.
//

import SwiftUI
import SwiftData

struct MainTabView: View {
    @Query private var sessions: [BreathingSession]
    
    var currentStreak: Int {
        BreathingSession.calculateStats(from: sessions).currentStreak
    }
    
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Label("Respirar", systemImage: "wind")
                }
            
            HistoryView()
                .tabItem {
                    Label("Historial", systemImage: "clock.arrow.circlepath")
                }
                .badge(sessions.count)
            
            StatisticsView()
                .tabItem {
                    Label("Estadísticas", systemImage: "chart.bar.fill")
                }
                .badge(currentStreak > 0 ? currentStreak : 0)
        }
    }
}

#Preview {
    MainTabView()
        .modelContainer(for: BreathingSession.self, inMemory: true)
}
