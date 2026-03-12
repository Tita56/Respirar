//
//  HistoryView.swift
//  Respira
//
//  Created by Amada Hernández Borges on 3/8/26.
//

import SwiftUI
import SwiftData

struct HistoryView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \BreathingSession.date, order: .reverse) private var sessions: [BreathingSession]
    @State private var showingDeleteAlert = false
    @State private var sessionToDelete: BreathingSession?
    
    var body: some View {
        NavigationStack {
            Group {
                if sessions.isEmpty {
                    emptyStateView
                } else {
                    sessionsList
                }
            }
            .navigationTitle("Historial")
            .toolbar {
                if !sessions.isEmpty {
                    ToolbarItem(placement: .topBarTrailing) {
                        NavigationLink(destination: StatisticsView()) {
                            Image(systemName: "chart.bar.fill")
                        }
                    }
                }
            }
            .alert("Eliminar sesión", isPresented: $showingDeleteAlert) {
                Button("Cancelar", role: .cancel) { }
                Button("Eliminar", role: .destructive) {
                    if let session = sessionToDelete {
                        deleteSession(session)
                    }
                }
            } message: {
                Text("¿Estás seguro de que quieres eliminar esta sesión?")
            }
        }
    }
    
    private var emptyStateView: some View {
        VStack(spacing: 20) {
            Image(systemName: "clock.arrow.circlepath")
                .font(.system(size: 80))
                .foregroundStyle(.secondary)
            
            Text("Sin sesiones aún")
                .font(.title2)
                .fontWeight(.semibold)
            
            Text("Completa tu primera sesión de respiración y aparecerá aquí")
                .font(.body)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
        .frame(maxHeight: .infinity)
    }
    
    private var sessionsList: some View {
        List {
            ForEach(groupedSessions.keys.sorted(by: >), id: \.self) { date in
                Section(header: Text(formatSectionDate(date))) {
                    ForEach(groupedSessions[date] ?? []) { session in
                        SessionRow(session: session)
                            .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                Button(role: .destructive) {
                                    sessionToDelete = session
                                    showingDeleteAlert = true
                                } label: {
                                    Label("Eliminar", systemImage: "trash")
                                }
                            }
                    }
                }
            }
        }
    }
    
    private var groupedSessions: [Date: [BreathingSession]] {
        let calendar = Calendar.current
        return Dictionary(grouping: sessions) { session in
            calendar.startOfDay(for: session.date)
        }
    }
    
    private func formatSectionDate(_ date: Date) -> String {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let yesterday = calendar.date(byAdding: .day, value: -1, to: today)!
        
        if calendar.isDate(date, inSameDayAs: today) {
            return "Hoy"
        } else if calendar.isDate(date, inSameDayAs: yesterday) {
            return "Ayer"
        } else {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter.string(from: date)
        }
    }
    
    private func deleteSession(_ session: BreathingSession) {
        withAnimation {
            modelContext.delete(session)
        }
    }
}

struct SessionRow: View {
    let session: BreathingSession
    
    var body: some View {
        HStack(spacing: 16) {
            // Icono del patrón
            Image(systemName: session.patternIcon)
                .font(.title2)
                .foregroundStyle(.blue)
                .frame(width: 40, height: 40)
                .background(Color.blue.opacity(0.1))
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text(session.patternName)
                    .font(.headline)
                
                HStack(spacing: 12) {
                    Label("\(session.cyclesCompleted) ciclos", systemImage: "repeat")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    
                    Label(session.formattedDuration, systemImage: "clock")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            
            Spacer()
            
            // Hora
            Text(formatTime(session.date))
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding(.vertical, 4)
    }
    
    private func formatTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

#Preview {
    HistoryView()
        .modelContainer(for: BreathingSession.self, inMemory: true)
}
