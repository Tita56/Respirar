//
//  MainTabView+Debug.swift
//  Respira
//
//  Created by Amada Hernández Borges on 3/8/26.
//

import SwiftUI
import SwiftData

/// Versión de MainTabView con tab de debug para generar datos de prueba
/// ⚠️ SOLO USAR EN DESARROLLO - Eliminar antes de producción
struct MainTabViewDebug: View {
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
            
            // 🧪 Tab de debug
            TestDataView()
                .tabItem {
                    Label("Debug", systemImage: "ladybug.fill")
                }
            
            // 🎵 Tab de debug de audio background
            BackgroundAudioDebugView()
                .tabItem {
                    Label("Audio", systemImage: "speaker.wave.3")
                }
        }
    }
}

#Preview {
    MainTabViewDebug()
        .modelContainer(for: BreathingSession.self, inMemory: true)
}
