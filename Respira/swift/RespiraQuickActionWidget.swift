//
//  RespiraQuickActionWidget.swift
//  RespiraWidget
//
//  Created by Amada Hernández Borges on 3/21/26.
//

import WidgetKit
import SwiftUI
import AppIntents

// MARK: - App Intent para iniciar respiración
struct StartBreathingIntent: AppIntent {
    static var title: LocalizedStringResource = "Iniciar Respiración"
    static var description = IntentDescription("Inicia una sesión de respiración con el patrón seleccionado")
    
    @Parameter(title: "Patrón")
    var patternName: String
    
    init() {
        self.patternName = "Box Breathing"
    }
    
    init(patternName: String) {
        self.patternName = patternName
    }
    
    func perform() async throws -> some IntentResult {
        // Guardar el patrón seleccionado en UserDefaults para que la app lo use
        //userDefaults.set(patternName, forKey: "selectedPatternFromWidget")
        //userDefaults.synchronize()
        
        // Abrir la app
        return .result()
    }
}

// MARK: - Quick Action Widget Entry
struct QuickActionEntry: TimelineEntry {
    let date: Date
}

// MARK: - Quick Action Provider
struct QuickActionProvider: TimelineProvider {
    func placeholder(in context: Context) -> QuickActionEntry {
        QuickActionEntry(date: Date())
    }
    
    func getSnapshot(in context: Context, completion: @escaping (QuickActionEntry) -> Void) {
        completion(QuickActionEntry(date: Date()))
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<QuickActionEntry>) -> Void) {
        let entry = QuickActionEntry(date: Date())
        let timeline = Timeline(entries: [entry], policy: .never)
        completion(timeline)
    }
}

// MARK: - Quick Action Widget View
struct QuickActionWidgetView: View {
    var entry: QuickActionProvider.Entry
    @Environment(\.widgetFamily) var family
    
    var body: some View {
        switch family {
        case .systemMedium:
            MediumQuickActionView()
        case .systemLarge:
            LargeQuickActionView()
        default:
            MediumQuickActionView()
        }
    }
}

// MARK: - Medium Quick Action View
struct MediumQuickActionView: View {
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.blue.opacity(0.5),
                    Color.purple.opacity(0.3)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            
            VStack(spacing: 12) {
                Text("Respiración Rápida")
                    .font(.headline)
                    .foregroundColor(.white)
                
                HStack(spacing: 12) {
                    QuickActionButton(
                        icon: "square.fill",
                        label: "Box",
                        patternName: "Box Breathing"
                    )
                    
                    QuickActionButton(
                        icon: "moon.stars.fill",
                        label: "4-7-8",
                        patternName: "4-7-8 Relajante"
                    )
                }
            }
            .padding()
        }
    }
}

// MARK: - Large Quick Action View
struct LargeQuickActionView: View {
    let patterns = [
        ("Box Breathing", "square.fill"),
        ("4-7-8 Relajante", "moon.stars.fill"),
        ("5-5-5 Equilibrio", "circle.hexagongrid.fill"),
        ("Respiración Energizante", "bolt.fill"),
        ("Calma Profunda", "leaf.fill")
    ]
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.blue.opacity(0.5),
                    Color.purple.opacity(0.3)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            
            VStack(spacing: 12) {
                HStack {
                    Image(systemName: "wind")
                        .font(.title2)
                        .foregroundColor(.white)
                    
                    Text("Acceso Rápido")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Spacer()
                }
                .padding(.horizontal)
                
                VStack(spacing: 10) {
                    ForEach(patterns, id: \.0) { pattern in
                        Button(intent: StartBreathingIntent(patternName: pattern.0)) {
                            HStack {
                                Image(systemName: pattern.1)
                                    .font(.title3)
                                    .foregroundColor(.white)
                                    .frame(width: 30)
                                
                                Text(pattern.0)
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                                    .foregroundColor(.white)
                                
                                Spacer()
                                
                                Image(systemName: "play.fill")
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.7))
                            }
                            .padding(.horizontal, 12)
                            .padding(.vertical, 10)
                            .background(Color.white.opacity(0.15))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
    }
}

// MARK: - Quick Action Button
struct QuickActionButton: View {
    let icon: String
    let label: String
    let patternName: String
    
    var body: some View {
        Button(intent: StartBreathingIntent(patternName: patternName)) {
            VStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.title)
                    .foregroundColor(.white)
                
                Text(label)
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(Color.white.opacity(0.2))
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Widget Configuration
struct RespiraQuickActionWidget: Widget {
    let kind: String = "RespiraQuickActionWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: QuickActionProvider()) { entry in
            QuickActionWidgetView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .configurationDisplayName("Acceso Rápido")
        .description("Inicia una sesión de respiración directamente desde el widget.")
        .supportedFamilies([.systemMedium, .systemLarge])
    }
}

// MARK: - Preview
#Preview(as: .systemMedium) {
    RespiraQuickActionWidget()
} timeline: {
    QuickActionEntry(date: .now)
}

#Preview(as: .systemLarge) {
    RespiraQuickActionWidget()
} timeline: {
    QuickActionEntry(date: .now)
}
