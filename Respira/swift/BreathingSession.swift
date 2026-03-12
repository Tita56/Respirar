//
//  BreathingSession.swift
//  Respira
//
//  Created by Amada Hernández Borges on 3/8/26.
//

import Foundation
import SwiftData

@Model
final class BreathingSession {
    var id: UUID
    var date: Date
    var patternName: String
    var patternIcon: String
    var cyclesCompleted: Int
    var durationSeconds: Double
    
    init(
        id: UUID = UUID(),
        date: Date = Date(),
        patternName: String,
        patternIcon: String,
        cyclesCompleted: Int,
        durationSeconds: Double
    ) {
        self.id = id
        self.date = date
        self.patternName = patternName
        self.patternIcon = patternIcon
        self.cyclesCompleted = cyclesCompleted
        self.durationSeconds = durationSeconds
    }
    
    // Computed properties útiles
    var durationMinutes: Double {
        durationSeconds / 60.0
    }
    
    var formattedDuration: String {
        let minutes = Int(durationSeconds) / 60
        let seconds = Int(durationSeconds) % 60
        
        if minutes > 0 {
            return "\(minutes)m \(seconds)s"
        } else {
            return "\(seconds)s"
        }
    }
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

// MARK: - Statistics Helper
extension BreathingSession {
    /// Calcula estadísticas de un conjunto de sesiones
    static func calculateStats(from sessions: [BreathingSession]) -> SessionStats {
        guard !sessions.isEmpty else {
            return SessionStats(
                totalSessions: 0,
                totalMinutes: 0,
                totalCycles: 0,
                averageDuration: 0,
                currentStreak: 0,
                longestStreak: 0,
                favoritePattern: nil
            )
        }
        
        let totalMinutes = sessions.reduce(0) { $0 + $1.durationMinutes }
        let totalCycles = sessions.reduce(0) { $0 + $1.cyclesCompleted }
        let averageDuration = totalMinutes / Double(sessions.count)
        
        // Calcular racha actual y más larga
        let streaks = calculateStreaks(sessions: sessions)
        
        // Encontrar el patrón favorito
        let patternCounts = Dictionary(grouping: sessions, by: { $0.patternName })
        let favoritePattern = patternCounts.max(by: { $0.value.count < $1.value.count })?.key
        
        return SessionStats(
            totalSessions: sessions.count,
            totalMinutes: totalMinutes,
            totalCycles: totalCycles,
            averageDuration: averageDuration,
            currentStreak: streaks.current,
            longestStreak: streaks.longest,
            favoritePattern: favoritePattern
        )
    }
    
    private static func calculateStreaks(sessions: [BreathingSession]) -> (current: Int, longest: Int) {
        guard !sessions.isEmpty else { return (0, 0) }
        
        let calendar = Calendar.current
        let sortedSessions = sessions.sorted { $0.date > $1.date }
        
        // Agrupar por día
        var sessionsByDay: [Date: [BreathingSession]] = [:]
        for session in sortedSessions {
            let day = calendar.startOfDay(for: session.date)
            sessionsByDay[day, default: []].append(session)
        }
        
        let uniqueDays = Array(sessionsByDay.keys).sorted(by: >)
        
        guard !uniqueDays.isEmpty else { return (0, 0) }
        
        var currentStreak = 0
        var longestStreak = 0
        var tempStreak = 0
        
        // Verificar si hay sesión hoy o ayer
        let today = calendar.startOfDay(for: Date())
        let yesterday = calendar.date(byAdding: .day, value: -1, to: today)!
        
        var expectedDate = uniqueDays[0] >= yesterday ? today : uniqueDays[0]
        
        for day in uniqueDays {
            let daysDiff = calendar.dateComponents([.day], from: day, to: expectedDate).day ?? 0
            
            if daysDiff == 0 {
                tempStreak += 1
                if expectedDate == today || expectedDate == yesterday {
                    currentStreak = tempStreak
                }
            } else if daysDiff == 1 {
                tempStreak += 1
            } else {
                longestStreak = max(longestStreak, tempStreak)
                tempStreak = 1
            }
            
            expectedDate = calendar.date(byAdding: .day, value: -1, to: day)!
        }
        
        longestStreak = max(longestStreak, tempStreak)
        
        // Si la última sesión no es de hoy ni ayer, la racha actual es 0
        if let lastSession = uniqueDays.first,
           lastSession < yesterday {
            currentStreak = 0
        }
        
        return (currentStreak, longestStreak)
    }
}

// MARK: - SessionStats
struct SessionStats {
    let totalSessions: Int
    let totalMinutes: Double
    let totalCycles: Int
    let averageDuration: Double
    let currentStreak: Int
    let longestStreak: Int
    let favoritePattern: String?
}
