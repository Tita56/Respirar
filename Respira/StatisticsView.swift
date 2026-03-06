//
//  StatisticsView.swift
//  Respira
//
//  Created by Amada Hernández Borges on 3/8/26.
//

import SwiftUI
import SwiftData
import Charts

struct StatisticsView: View {
    @Query(sort: \BreathingSession.date, order: .reverse) private var sessions: [BreathingSession]
    @State private var selectedTimeRange: TimeRange = .week
    
    enum TimeRange: String, CaseIterable {
        case week = "Semana"
        case month = "Mes"
        case year = "Año"
        case all = "Todo"
    }
    
    var filteredSessions: [BreathingSession] {
        let calendar = Calendar.current
        let now = Date()
        
        switch selectedTimeRange {
        case .week:
            let weekAgo = calendar.date(byAdding: .day, value: -7, to: now)!
            return sessions.filter { $0.date >= weekAgo }
        case .month:
            let monthAgo = calendar.date(byAdding: .month, value: -1, to: now)!
            return sessions.filter { $0.date >= monthAgo }
        case .year:
            let yearAgo = calendar.date(byAdding: .year, value: -1, to: now)!
            return sessions.filter { $0.date >= yearAgo }
        case .all:
            return sessions
        }
    }
    
    var stats: SessionStats {
        BreathingSession.calculateStats(from: sessions)
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Selector de rango de tiempo
                Picker("Rango", selection: $selectedTimeRange) {
                    ForEach(TimeRange.allCases, id: \.self) { range in
                        Text(range.rawValue).tag(range)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                
                // Tarjetas de estadísticas principales
                statsCardsSection
                
                // Gráfica de minutos por día
                if !filteredSessions.isEmpty {
                    minutesChartSection
                }
                
                // Gráfica de patrones más usados
                if !filteredSessions.isEmpty {
                    patternsChartSection
                }
                
                // Gráfica de tendencia de ciclos
                if !filteredSessions.isEmpty {
                    cyclesChartSection
                }
            }
            .padding(.vertical)
        }
        .navigationTitle("Estadísticas")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // MARK: - Stats Cards
    private var statsCardsSection: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
            StatCard(
                icon: "flame.fill",
                iconColor: .orange,
                title: "Racha Actual",
                value: "\(stats.currentStreak)",
                subtitle: "días"
            )
            
            StatCard(
                icon: "chart.line.uptrend.xyaxis",
                iconColor: .green,
                title: "Mejor Racha",
                value: "\(stats.longestStreak)",
                subtitle: "días"
            )
            
            StatCard(
                icon: "clock.fill",
                iconColor: .blue,
                title: "Total Minutos",
                value: String(format: "%.0f", stats.totalMinutes),
                subtitle: "minutos"
            )
            
            StatCard(
                icon: "repeat.circle.fill",
                iconColor: .purple,
                title: "Total Ciclos",
                value: "\(stats.totalCycles)",
                subtitle: "ciclos"
            )
            
            StatCard(
                icon: "calendar",
                iconColor: .pink,
                title: "Sesiones",
                value: "\(stats.totalSessions)",
                subtitle: "totales"
            )
            
            StatCard(
                icon: "timer",
                iconColor: .indigo,
                title: "Promedio",
                value: String(format: "%.1f", stats.averageDuration),
                subtitle: "min/sesión"
            )
        }
        .padding(.horizontal)
    }
    
    // MARK: - Minutes Chart
    private var minutesChartSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Minutos por Día")
                .font(.headline)
                .padding(.horizontal)
            
            Chart {
                ForEach(dailyMinutes, id: \.date) { item in
                    BarMark(
                        x: .value("Día", item.date, unit: .day),
                        y: .value("Minutos", item.minutes)
                    )
                    .foregroundStyle(.blue.gradient)
                    .cornerRadius(4)
                }
            }
            .frame(height: 200)
            .padding(.horizontal)
            .chartXAxis {
                AxisMarks(values: .stride(by: .day)) { _ in
                    AxisGridLine()
                    AxisTick()
                    AxisValueLabel(format: .dateTime.day().month(), centered: true)
                }
            }
        }
        .padding(.vertical)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.05), radius: 8)
        .padding(.horizontal)
    }
    
    private var dailyMinutes: [(date: Date, minutes: Double)] {
        let calendar = Calendar.current
        let grouped = Dictionary(grouping: filteredSessions) { session in
            calendar.startOfDay(for: session.date)
        }
        
        return grouped.map { date, sessions in
            let totalMinutes = sessions.reduce(0) { $0 + $1.durationMinutes }
            return (date: date, minutes: totalMinutes)
        }
        .sorted { $0.date < $1.date }
    }
    
    // MARK: - Patterns Chart
    private var patternsChartSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Patrones Más Usados")
                .font(.headline)
                .padding(.horizontal)
            
            Chart {
                ForEach(patternCounts.sorted(by: { $0.value > $1.value }), id: \.key) { pattern, count in
                    BarMark(
                        x: .value("Sesiones", count),
                        y: .value("Patrón", pattern)
                    )
                    .foregroundStyle(by: .value("Patrón", pattern))
                    .cornerRadius(4)
                    .annotation(position: .trailing) {
                        Text("\(count)")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .frame(height: CGFloat(patternCounts.count * 50))
            .padding(.horizontal)
            .chartLegend(.hidden)
        }
        .padding(.vertical)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.05), radius: 8)
        .padding(.horizontal)
    }
    
    private var patternCounts: [String: Int] {
        Dictionary(grouping: filteredSessions, by: { $0.patternName })
            .mapValues { $0.count }
    }
    
    // MARK: - Cycles Chart
    private var cyclesChartSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Ciclos Completados")
                .font(.headline)
                .padding(.horizontal)
            
            Chart {
                ForEach(filteredSessions.prefix(20).reversed(), id: \.id) { session in
                    LineMark(
                        x: .value("Sesión", session.date),
                        y: .value("Ciclos", session.cyclesCompleted)
                    )
                    .foregroundStyle(.purple.gradient)
                    .interpolationMethod(.catmullRom)
                    
                    PointMark(
                        x: .value("Sesión", session.date),
                        y: .value("Ciclos", session.cyclesCompleted)
                    )
                    .foregroundStyle(.purple)
                }
            }
            .frame(height: 180)
            .padding(.horizontal)
            .chartXAxis {
                AxisMarks(values: .automatic) { _ in
                    AxisGridLine()
                    AxisTick()
                    AxisValueLabel(format: .dateTime.day().month(), centered: true)
                }
            }
        }
        .padding(.vertical)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.05), radius: 8)
        .padding(.horizontal)
    }
}

// MARK: - Stat Card Component
struct StatCard: View {
    let icon: String
    let iconColor: Color
    let title: String
    let value: String
    let subtitle: String
    
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 32))
                .foregroundStyle(iconColor.gradient)
            
            VStack(spacing: 4) {
                Text(value)
                    .font(.system(.title2, design: .rounded))
                    .fontWeight(.bold)
                
                Text(subtitle)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                
                Text(title)
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.05), radius: 8)
    }
}

#Preview {
    NavigationStack {
        StatisticsView()
            .modelContainer(for: BreathingSession.self, inMemory: true)
    }
}
