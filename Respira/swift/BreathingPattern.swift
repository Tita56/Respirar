//
//  BreathingPattern.swift
//  Respira
//
//  Created by Amada Hernández Borges on 3/6/26.
//

import SwiftUI

struct BreathingPattern: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let description: String
    let icon: String
    let phases: [BreathPhase]
    
    static let patterns: [BreathingPattern] = [
        BreathingPattern(
            name: "4-7-8 Relajante",
            description: "Ideal para dormir y reducir ansiedad",
            icon: "moon.stars.fill",
            phases: [
                BreathPhase(type: .inhale, duration: 4.0),
                BreathPhase(type: .hold, duration: 7.0),
                BreathPhase(type: .exhale, duration: 8.0),
                BreathPhase(type: .pause, duration: 2.0)
            ]
        ),
        BreathingPattern(
            name: "Box Breathing",
            description: "Técnica militar para concentración",
            icon: "square.fill",
            phases: [
                BreathPhase(type: .inhale, duration: 4.0),
                BreathPhase(type: .hold, duration: 4.0),
                BreathPhase(type: .exhale, duration: 4.0),
                BreathPhase(type: .hold, duration: 4.0)
            ]
        ),
        BreathingPattern(
            name: "5-5-5 Equilibrio",
            description: "Balance perfecto para el día",
            icon: "circle.hexagongrid.fill",
            phases: [
                BreathPhase(type: .inhale, duration: 5.0),
                BreathPhase(type: .hold, duration: 5.0),
                BreathPhase(type: .exhale, duration: 5.0)
            ]
        ),
        BreathingPattern(
            name: "Respiración Energizante",
            description: "Para aumentar energía y vitalidad",
            icon: "bolt.fill",
            phases: [
                BreathPhase(type: .inhale, duration: 2.0),
                BreathPhase(type: .exhale, duration: 3.0),
                BreathPhase(type: .pause, duration: 1.0)
            ]
        ),
        BreathingPattern(
            name: "Calma Profunda",
            description: "Respiración muy lenta para meditación",
            icon: "leaf.fill",
            phases: [
                BreathPhase(type: .inhale, duration: 6.0),
                BreathPhase(type: .hold, duration: 3.0),
                BreathPhase(type: .exhale, duration: 9.0),
                BreathPhase(type: .pause, duration: 3.0)
            ]
        )
    ]
    
    static func == (lhs: BreathingPattern, rhs: BreathingPattern) -> Bool {
        lhs.id == rhs.id
    }
}

struct BreathPhase {
    let type: BreathPhaseType
    let duration: Double
}

enum BreathPhaseType {
    case inhale, hold, exhale, pause
    
    var instruction: String {
        switch self {
        case .inhale: return "Inhala profundamente"
        case .hold: return "Mantén la respiración"
        case .exhale: return "Exhala lentamente"
        case .pause: return "Pausa"
        }
    }
    
    var color: Color {
        switch self {
        case .inhale: return .blue
        case .hold: return .purple
        case .exhale: return .blue
        case .pause: return .yellow
        }
    }
    
    var soundName: String {
        switch self {
        case .inhale: return "inhale"
        case .hold: return "hold"
        case .exhale: return "exhale"
        case .pause: return "pause"
        }
    }
}
