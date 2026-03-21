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
    /// Formato: group.[tu-bundle-id]
    /// Bundle ID: casatita.Respira
    static let identifier = "group.casatita.Respira"
    
    /// Container URL compartido para SwiftData
    static var containerURL: URL {
        guard let url = FileManager.default.containerURL(
            forSecurityApplicationGroupIdentifier: identifier
        ) else {
            #if DEBUG
            // En desarrollo, usa el directorio de documentos local si el App Group no está configurado
            print("⚠️ App Group no configurado. Usando almacenamiento local (los widgets no funcionarán).")
            return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            #else
            fatalError("App Group container no encontrado. Verifica que el App Group esté configurado correctamente.")
            #endif
        }
        return url
    }
    
    /// UserDefaults compartido para datos simples
    static var userDefaults: UserDefaults {
        guard let defaults = UserDefaults(suiteName: identifier) else {
            #if DEBUG
            // En desarrollo, usa UserDefaults estándar si el App Group no está configurado
            print("⚠️ App Group no configurado. Usando UserDefaults estándar (los widgets no funcionarán).")
            return UserDefaults.standard
            #else
            fatalError("No se pudo crear UserDefaults con el App Group")
            #endif
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
