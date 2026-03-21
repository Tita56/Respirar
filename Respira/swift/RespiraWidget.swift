//
//  RespiraWidget.swift
//  RespiraWidget
//
//  Created by Amada Hernández Borges on 3/21/26.
//

import WidgetKit
import SwiftUI

// MARK: - Timeline Entry
struct RespiraWidgetEntry: TimelineEntry {
    let date: Date
    let widgetData: WidgetData
}

// MARK: - Timeline Provider
struct RespiraWidgetProvider: TimelineProvider {
    func placeholder(in context: Context) -> RespiraWidgetEntry {
        RespiraWidgetEntry(
            date: Date(),
            widgetData: WidgetData(
                currentStreak: 7,
                totalSessions: 42,
                lastSessionDate: Date(),
                favoritePattern: "Box Breathing",
                favoritePatternIcon: "square.fill"
            )
        )
    }
    
    func getSnapshot(in context: Context, completion: @escaping (RespiraWidgetEntry) -> Void) {
        let data = WidgetDataManager.shared.getWidgetData()
        let entry = RespiraWidgetEntry(date: Date(), widgetData: data)
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<RespiraWidgetEntry>) -> Void) {
        let data = WidgetDataManager.shared.getWidgetData()
        let entry = RespiraWidgetEntry(date: Date(), widgetData: data)
        
        // Actualizar el widget cada hora
        let nextUpdate = Calendar.current.date(byAdding: .hour, value: 1, to: Date())!
        let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
        
        completion(timeline)
    }
}

// MARK: - Widget Views
struct RespiraWidgetEntryView: View {
    @Environment(\.widgetFamily) var family
    var entry: RespiraWidgetProvider.Entry
    
    var body: some View {
        switch family {
        case .systemSmall:
            SmallWidgetView(data: entry.widgetData)
        case .systemMedium:
            MediumWidgetView(data: entry.widgetData)
        case .systemLarge:
            LargeWidgetView(data: entry.widgetData)
        case .accessoryCircular:
            CircularWidgetView(data: entry.widgetData)
        case .accessoryRectangular:
            RectangularWidgetView(data: entry.widgetData)
        case .accessoryInline:
            InlineWidgetView(data: entry.widgetData)
        default:
            SmallWidgetView(data: entry.widgetData)
        }
    }
}

// MARK: - Small Widget (Estado Actual)
struct SmallWidgetView: View {
    let data: WidgetData
    
    var body: some View {
        ZStack {
            // Fondo con degradado
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.blue.opacity(0.6),
                    Color.purple.opacity(0.4)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            
            VStack(spacing: 8) {
                // Icono de racha
                Image(systemName: "flame.fill")
                    .font(.system(size: 32))
                    .foregroundStyle(.orange, .yellow)
                
                // Número de racha
                Text("\(data.currentStreak)")
                    .font(.system(size: 36, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                
                // Etiqueta
                Text("días seguidos")
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.9))
                
                // Total de sesiones
                Text("\(data.totalSessions) sesiones")
                    .font(.caption2)
                    .foregroundColor(.white.opacity(0.7))
            }
            .padding()
        }
    }
}

// MARK: - Medium Widget (Estadísticas + Acceso Rápido)
struct MediumWidgetView: View {
    let data: WidgetData
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.blue.opacity(0.6),
                    Color.purple.opacity(0.4)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            
            HStack(spacing: 0) {
                // Sección izquierda: Racha
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Image(systemName: "flame.fill")
                            .font(.title2)
                            .foregroundStyle(.orange, .yellow)
                        
                        Text("\(data.currentStreak)")
                            .font(.system(size: 40, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                    }
                    
                    Text("Racha actual")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.9))
                    
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("\(data.totalSessions) sesiones")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.8))
                        
                        Text(data.lastSessionText)
                            .font(.caption2)
                            .foregroundColor(.white.opacity(0.6))
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Divider()
                    .background(Color.white.opacity(0.3))
                
                // Sección derecha: Patrón favorito
                VStack(spacing: 8) {
                    if let pattern = data.favoritePattern,
                       let icon = data.favoritePatternIcon {
                        Image(systemName: icon)
                            .font(.system(size: 32))
                            .foregroundColor(.white)
                        
                        Text("Favorito")
                            .font(.caption2)
                            .foregroundColor(.white.opacity(0.8))
                        
                        Text(pattern)
                            .font(.caption)
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .lineLimit(2)
                    } else {
                        Image(systemName: "wind")
                            .font(.system(size: 32))
                            .foregroundColor(.white)
                        
                        Text("Comienza\ntu práctica")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.8))
                            .multilineTextAlignment(.center)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
            }
        }
    }
}

// MARK: - Large Widget (Vista Completa)
struct LargeWidgetView: View {
    let data: WidgetData
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.blue.opacity(0.6),
                    Color.purple.opacity(0.4)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            
            VStack(spacing: 16) {
                // Header
                HStack {
                    Image(systemName: "wind")
                        .font(.title)
                        .foregroundColor(.white)
                    
                    Text("Respira")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Spacer()
                }
                .padding(.horizontal)
                
                // Stats principales
                HStack(spacing: 20) {
                    WidgetStatCard(
                        icon: "flame.fill",
                        value: "\(data.currentStreak)",
                        label: "Racha",
                        iconColor: .orange
                    )
                    
                    WidgetStatCard(
                        icon: "checkmark.circle.fill",
                        value: "\(data.totalSessions)",
                        label: "Sesiones",
                        iconColor: .green
                    )
                }
                .padding(.horizontal)
                
                Divider()
                    .background(Color.white.opacity(0.3))
                    .padding(.horizontal)
                
                // Patrón favorito
                VStack(spacing: 12) {
                    Text("Tu patrón favorito")
                        .font(.headline)
                        .foregroundColor(.white.opacity(0.9))
                    
                    if let pattern = data.favoritePattern,
                       let icon = data.favoritePatternIcon {
                        HStack {
                            Image(systemName: icon)
                                .font(.system(size: 40))
                                .foregroundColor(.white)
                            
                            Text(pattern)
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                        }
                    } else {
                        Text("Aún no tienes un patrón favorito")
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.7))
                    }
                }
                .padding()
                .background(Color.white.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.horizontal)
                
                Spacer()
                
                // Última sesión
                Text("Última práctica: \(data.lastSessionText)")
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.7))
                    .padding(.bottom)
            }
            .padding(.vertical)
        }
    }
}

// MARK: - Widget Stat Card Component
struct WidgetStatCard: View {
    let icon: String
    let value: String
    let label: String
    let iconColor: Color
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title)
                .foregroundStyle(iconColor, iconColor.opacity(0.6))
            
            Text(value)
                .font(.system(size: 32, weight: .bold, design: .rounded))
                .foregroundColor(.white)
            
            Text(label)
                .font(.caption)
                .foregroundColor(.white.opacity(0.8))
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.white.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

// MARK: - Lock Screen Widgets

// Circular (para Apple Watch y Lock Screen)
struct CircularWidgetView: View {
    let data: WidgetData
    
    var body: some View {
        ZStack {
            AccessoryWidgetBackground()
            
            VStack(spacing: 2) {
                Image(systemName: "flame.fill")
                    .font(.title3)
                
                Text("\(data.currentStreak)")
                    .font(.title2)
                    .fontWeight(.bold)
            }
        }
    }
}

// Rectangular (para Lock Screen)
struct RectangularWidgetView: View {
    let data: WidgetData
    
    var body: some View {
        HStack {
            Image(systemName: "flame.fill")
                .font(.title2)
            
            VStack(alignment: .leading, spacing: 2) {
                Text("\(data.currentStreak) días seguidos")
                    .font(.headline)
                
                Text("\(data.totalSessions) sesiones")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
        }
        .padding(.horizontal, 4)
    }
}

// Inline (para Lock Screen)
struct InlineWidgetView: View {
    let data: WidgetData
    
    var body: some View {
        Text("🔥 \(data.currentStreak) días · \(data.totalSessions) sesiones")
    }
}

// MARK: - Widget Configuration
struct RespiraWidget: Widget {
    let kind: String = "RespiraWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: RespiraWidgetProvider()) { entry in
            RespiraWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .configurationDisplayName("Respira")
        .description("Visualiza tu racha de respiración y estadísticas.")
        .supportedFamilies([
            .systemSmall,
            .systemMedium,
            .systemLarge,
            .accessoryCircular,
            .accessoryRectangular,
            .accessoryInline
        ])
    }
}

// MARK: - Previews
#Preview(as: .systemSmall) {
    RespiraWidget()
} timeline: {
    RespiraWidgetEntry(
        date: .now,
        widgetData: WidgetData(
            currentStreak: 7,
            totalSessions: 42,
            lastSessionDate: Date(),
            favoritePattern: "Box Breathing",
            favoritePatternIcon: "square.fill"
        )
    )
}

#Preview(as: .systemMedium) {
    RespiraWidget()
} timeline: {
    RespiraWidgetEntry(
        date: .now,
        widgetData: WidgetData(
            currentStreak: 7,
            totalSessions: 42,
            lastSessionDate: Date(),
            favoritePattern: "Box Breathing",
            favoritePatternIcon: "square.fill"
        )
    )
}

#Preview(as: .systemLarge) {
    RespiraWidget()
} timeline: {
    RespiraWidgetEntry(
        date: .now,
        widgetData: WidgetData(
            currentStreak: 7,
            totalSessions: 42,
            lastSessionDate: Date(),
            favoritePattern: "Box Breathing",
            favoritePatternIcon: "square.fill"
        )
    )
}
