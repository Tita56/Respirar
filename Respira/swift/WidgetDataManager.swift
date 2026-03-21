//
//  WidgetDataManager.swift
//  Respira
//
//  Created by Amada Hernández Borges on 3/21/26.
//

import Foundation
import WidgetKit

/// Manager para sincronizar datos entre la app y el widget
class WidgetDataManager {
    static let shared = WidgetDataManager()
    
    private let defaults = AppGroup.userDefaults
    
    private init() {}
    
    /// Actualiza los datos compartidos con el widget
    func updateWidgetData(stats: SessionStats) {
        defaults.set(stats.currentStreak, forKey: AppGroup.Keys.currentStreak)
        defaults.set(stats.totalSessions, forKey: AppGroup.Keys.totalSessions)
        defaults.set(Date(), forKey: AppGroup.Keys.lastSessionDate)
        
        if let favoritePattern = stats.favoritePattern {
            defaults.set(favoritePattern, forKey: AppGroup.Keys.favoritePattern)
            
            // Buscar el icono del patrón favorito
            if let pattern = BreathingPattern.patterns.first(where: { $0.name == favoritePattern }) {
                defaults.set(pattern.icon, forKey: AppGroup.Keys.favoritePatternIcon)
            }
        }
        
        // Forzar sincronización
        defaults.synchronize()
        
        // Recargar todos los widgets
        WidgetCenter.shared.reloadAllTimelines()
    }
    
    /// Obtiene los datos actuales para mostrar en el widget
    func getWidgetData() -> WidgetData {
        let currentStreak = defaults.integer(forKey: AppGroup.Keys.currentStreak)
        let totalSessions = defaults.integer(forKey: AppGroup.Keys.totalSessions)
        let lastSessionDate = defaults.object(forKey: AppGroup.Keys.lastSessionDate) as? Date
        let favoritePattern = defaults.string(forKey: AppGroup.Keys.favoritePattern)
        let favoritePatternIcon = defaults.string(forKey: AppGroup.Keys.favoritePatternIcon)
        
        return WidgetData(
            currentStreak: currentStreak,
            totalSessions: totalSessions,
            lastSessionDate: lastSessionDate,
            favoritePattern: favoritePattern,
            favoritePatternIcon: favoritePatternIcon
        )
    }
}

// MARK: - Widget Data Model
struct WidgetData {
    let currentStreak: Int
    let totalSessions: Int
    let lastSessionDate: Date?
    let favoritePattern: String?
    let favoritePatternIcon: String?
    
    var lastSessionText: String {
        guard let date = lastSessionDate else {
            return "Sin sesiones"
        }
        
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .short
        return formatter.localizedString(for: date, relativeTo: Date())
    }
}
