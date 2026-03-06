//
//  SoundPreset.swift
//  Respira
//
//  Created by Amada Hernández Borges on 3/8/26.
//

import Foundation

/// Configuración de un armónico individual
struct Harmonic {
    let frequencyMultiplier: Double
    let amplitude: Double
}

/// Configuración de la envolvente de sonido
struct EnvelopeConfig {
    let attackTime: Double  // Tiempo de ataque en segundos
    let decayRate: Double   // Velocidad de decaimiento
}

/// Preset completo de sonido con todos sus parámetros
struct SoundPreset: Identifiable, Codable {
    let id: String
    let name: String
    let icon: String
    let description: String
    let harmonics: [HarmonicData]
    let envelope: EnvelopeData
    let baseAmplitude: Double
    
    struct HarmonicData: Codable {
        let frequencyMultiplier: Double
        let amplitude: Double
    }
    
    struct EnvelopeData: Codable {
        let attackTime: Double
        let decayRate: Double
    }
    
    // MARK: - Presets predefinidos
    
    static let bell = SoundPreset(
        id: "bell",
        name: "Campanas",
        icon: "bell.fill",
        description: "Tonos de campana suaves y relajantes",
        harmonics: [
            HarmonicData(frequencyMultiplier: 1.0, amplitude: 1.0),
            HarmonicData(frequencyMultiplier: 2.4, amplitude: 0.6),
            HarmonicData(frequencyMultiplier: 3.8, amplitude: 0.35),
            HarmonicData(frequencyMultiplier: 5.2, amplitude: 0.2),
            HarmonicData(frequencyMultiplier: 6.8, amplitude: 0.1)
        ],
        envelope: EnvelopeData(attackTime: 0.03, decayRate: 3.5),
        baseAmplitude: 0.25
    )
    
    static let singingBowl = SoundPreset(
        id: "singing_bowl",
        name: "Cuencos Tibetanos",
        icon: "circle.hexagongrid.fill",
        description: "Sonidos profundos y meditativos",
        harmonics: [
            HarmonicData(frequencyMultiplier: 1.0, amplitude: 1.0),
            HarmonicData(frequencyMultiplier: 2.0, amplitude: 0.8),
            HarmonicData(frequencyMultiplier: 3.0, amplitude: 0.6),
            HarmonicData(frequencyMultiplier: 4.0, amplitude: 0.4),
            HarmonicData(frequencyMultiplier: 5.0, amplitude: 0.3),
            HarmonicData(frequencyMultiplier: 6.0, amplitude: 0.2)
        ],
        envelope: EnvelopeData(attackTime: 0.08, decayRate: 2.0),
        baseAmplitude: 0.3
    )
    
    static let pureTone = SoundPreset(
        id: "pure_tone",
        name: "Tonos Puros",
        icon: "waveform",
        description: "Ondas senoidales simples y claras",
        harmonics: [
            HarmonicData(frequencyMultiplier: 1.0, amplitude: 1.0)
        ],
        envelope: EnvelopeData(attackTime: 0.05, decayRate: 4.0),
        baseAmplitude: 0.2
    )
    
    static let soft = SoundPreset(
        id: "soft",
        name: "Suave",
        icon: "moon.stars.fill",
        description: "Tonos muy suaves para meditación profunda",
        harmonics: [
            HarmonicData(frequencyMultiplier: 1.0, amplitude: 1.0),
            HarmonicData(frequencyMultiplier: 2.0, amplitude: 0.4),
            HarmonicData(frequencyMultiplier: 3.0, amplitude: 0.2)
        ],
        envelope: EnvelopeData(attackTime: 0.1, decayRate: 2.5),
        baseAmplitude: 0.15
    )
    
    static let gong = SoundPreset(
        id: "gong",
        name: "Gong",
        icon: "circle.circle.fill",
        description: "Tonos resonantes y envolventes",
        harmonics: [
            HarmonicData(frequencyMultiplier: 1.0, amplitude: 1.0),
            HarmonicData(frequencyMultiplier: 1.6, amplitude: 0.7),
            HarmonicData(frequencyMultiplier: 2.3, amplitude: 0.5),
            HarmonicData(frequencyMultiplier: 3.1, amplitude: 0.4),
            HarmonicData(frequencyMultiplier: 4.2, amplitude: 0.3),
            HarmonicData(frequencyMultiplier: 5.5, amplitude: 0.2),
            HarmonicData(frequencyMultiplier: 7.1, amplitude: 0.15)
        ],
        envelope: EnvelopeData(attackTime: 0.02, decayRate: 1.8),
        baseAmplitude: 0.28
    )
    
    /// Todos los presets disponibles
    static let allPresets: [SoundPreset] = [
        .bell,
        .singingBowl,
        .pureTone,
        .soft,
        .gong
    ]
}
