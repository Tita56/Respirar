//
//  AppGroup.swift
//  Respira
//
//  Created by Amada Hernández Borges on 3/21/26.
//

import Foundation

/// Configuración de App Group para compartir datos entre la app y el widget
enum AppGroup {
    /// El identificador del App Group (debe coincidir en Capabilities)
    /// Formato: group.com.tudominio.respira
    static let identifier = "group.com.respira.shared"
    
    /// Container URL compartido para SwiftData
    static var containerURL: URL {
        guard let url = FileManager.default.containerURL(
            forSecurityApplicationGroupIdentifier: identifier
        ) else {
            fatalError("App Group container no encontrado. Verifica que el App Group esté configurado correctamente.")
        }
        return url
    }
    
    /// UserDefaults compartido para datos simples
    static var userDefaults: UserDefaults {
        guard let defaults = UserDefaults(suiteName: identifier) else {
            fatalError("No se pudo crear UserDefaults con el App Group")
        }
        return defaults
    }
}

// MARK: - UserDefaults Keys
extension AppGroup {
    enum Keys {
        static let lastSessionDate = "lastSessionDate"
        static let currentStreak = "currentStreak"
        static let totalSessions = "totalSessions"
        static let favoritePattern = "favoritePattern"
        static let favoritePatternIcon = "favoritePatternIcon"
    }
}
