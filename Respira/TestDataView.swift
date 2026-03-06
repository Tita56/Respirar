//
//  TestDataView.swift
//  Respira
//
//  Created by Amada Hernández Borges on 3/8/26.
//

import SwiftUI
import SwiftData

/// Vista de debug para generar datos de prueba
struct TestDataView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var sessions: [BreathingSession]
    @State private var showingAlert = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("🧪 Datos de Prueba")
                .font(.title)
                .fontWeight(.bold)
            
            Text("Sesiones actuales: \(sessions.count)")
                .font(.headline)
            
            Button {
                generateTestData()
                showingAlert = true
            } label: {
                Label("Generar Datos de Prueba", systemImage: "wand.and.stars")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(12)
            }
            .padding(.horizontal)
            
            Button {
                deleteAllSessions()
                showingAlert = true
            } label: {
                Label("Eliminar Todos los Datos", systemImage: "trash.fill")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .cornerRadius(12)
            }
            .padding(.horizontal)
            
            Text("⚠️ Solo para desarrollo")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .alert("Completado", isPresented: $showingAlert) {
            Button("OK") { }
        } message: {
            Text("Operación completada. Sesiones actuales: \(sessions.count)")
        }
    }
    
    private func generateTestData() {
        let calendar = Calendar.current
        let now = Date()
        let patterns = BreathingPattern.patterns
        
        // Generar sesiones de las últimas 2 semanas
        for daysAgo in 0..<14 {
            guard let date = calendar.date(byAdding: .day, value: -daysAgo, to: now) else { continue }
            
            // 1-3 sesiones por día
            let sessionsPerDay = Int.random(in: 1...3)
            
            for sessionIndex in 0..<sessionsPerDay {
                let randomPattern = patterns.randomElement()!
                let hourOffset = -sessionIndex * 4 - Int.random(in: 0...2)
                guard let sessionDate = calendar.date(byAdding: .hour, value: hourOffset, to: date) else { continue }
                
                let session = BreathingSession(
                    date: sessionDate,
                    patternName: randomPattern.name,
                    patternIcon: randomPattern.icon,
                    cyclesCompleted: Int.random(in: 3...20),
                    durationSeconds: Double.random(in: 120...1200)
                )
                
                modelContext.insert(session)
            }
        }
        
        try? modelContext.save()
    }
    
    private func deleteAllSessions() {
        for session in sessions {
            modelContext.delete(session)
        }
        try? modelContext.save()
    }
}

#Preview {
    TestDataView()
        .modelContainer(for: BreathingSession.self, inMemory: true)
}
