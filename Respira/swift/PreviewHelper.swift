//
//  PreviewHelper.swift
//  Respira
//
//  Created by Amada Hernández Borges on 3/8/26.
//

import Foundation
import SwiftData

@MainActor
class PreviewHelper {
    /// Genera sesiones de ejemplo para previews
    static func generateSampleSessions(in container: ModelContainer) {
        let context = container.mainContext
        
        let calendar = Calendar.current
        let now = Date()
        
        let patterns = BreathingPattern.patterns
        
        // Sesiones de esta semana
        for daysAgo in 0..<7 {
            guard let date = calendar.date(byAdding: .day, value: -daysAgo, to: now) else { continue }
            
            // 1-3 sesiones por día
            let sessionsPerDay = Int.random(in: 1...3)
            
            for sessionIndex in 0..<sessionsPerDay {
                let randomPattern = patterns.randomElement()!
                let hourOffset = -sessionIndex * 4
                guard let sessionDate = calendar.date(byAdding: .hour, value: hourOffset, to: date) else { continue }
                
                let session = BreathingSession(
                    date: sessionDate,
                    patternName: randomPattern.name,
                    patternIcon: randomPattern.icon,
                    cyclesCompleted: Int.random(in: 3...15),
                    durationSeconds: Double.random(in: 120...900)
                )
                
                context.insert(session)
            }
        }
        
        // Algunas sesiones más antiguas
        for weeksAgo in 1..<4 {
            guard let date = calendar.date(byAdding: .weekOfYear, value: -weeksAgo, to: now) else { continue }
            
            let randomPattern = patterns.randomElement()!
            
            let session = BreathingSession(
                date: date,
                patternName: randomPattern.name,
                patternIcon: randomPattern.icon,
                cyclesCompleted: Int.random(in: 5...12),
                durationSeconds: Double.random(in: 180...600)
            )
            
            context.insert(session)
        }
        
        try? context.save()
    }
}
