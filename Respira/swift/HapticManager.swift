//
//  HapticManager.swift
//  Respira
//
//  Created by Amada Hernández Borges on 3/8/26.
//

import UIKit
import SwiftUI

#if canImport(UIKit)
/// Manager para feedback háptico durante las sesiones de respiración
@Observable
class HapticManager {
    var isHapticEnabled: Bool {
        didSet {
            UserDefaults.standard.set(isHapticEnabled, forKey: "isHapticEnabled")
        }
    }
    
    // Generadores de feedback háptico
    private let impactLight = UIImpactFeedbackGenerator(style: .light)
    private let impactMedium = UIImpactFeedbackGenerator(style: .medium)
    private let impactHeavy = UIImpactFeedbackGenerator(style: .heavy)
    private let notificationGenerator = UINotificationFeedbackGenerator()
    private let selectionGenerator: UISelectionFeedbackGenerator
    
    init() {
        // Inicializar el selection generator
        self.selectionGenerator = UISelectionFeedbackGenerator()
        
        // Cargar preferencia guardada
        self.isHapticEnabled = UserDefaults.standard.bool(forKey: "isHapticEnabled")
        
        // Si es la primera vez, activar hápticos
        if UserDefaults.standard.object(forKey: "isHapticEnabled") == nil {
            self.isHapticEnabled = true
        }
        
        // Preparar generadores
        prepareGenerators()
    }
    
    private func prepareGenerators() {
        impactLight.prepare()
        impactMedium.prepare()
        impactHeavy.prepare()
        notificationGenerator.prepare()
        selectionGenerator.prepare()
    }
    
    // MARK: - Haptics para Fases de Respiración
    
    /// Feedback para inicio de inhalación (suave y ascendente)
    func playInhaleHaptic() {
        guard isHapticEnabled else { return }
        impactLight.impactOccurred()
    }
    
    /// Feedback para mantener respiración (medio, estable)
    func playHoldHaptic() {
        guard isHapticEnabled else { return }
        impactMedium.impactOccurred()
    }
    
    /// Feedback para exhalación (suave y descendente)
    func playExhaleHaptic() {
        guard isHapticEnabled else { return }
        impactLight.impactOccurred(intensity: 0.7)
    }
    
    /// Feedback para pausa (muy suave)
    func playPauseHaptic() {
        guard isHapticEnabled else { return }
        impactLight.impactOccurred(intensity: 0.5)
    }
    
    /// Feedback para fase de respiración genérico
    func playPhaseHaptic(for type: BreathPhaseType) {
        switch type {
        case .inhale:
            playInhaleHaptic()
        case .hold:
            playHoldHaptic()
        case .exhale:
            playExhaleHaptic()
        case .pause:
            playPauseHaptic()
        }
    }
    
    // MARK: - Haptics para Eventos de Sesión
    
    /// Feedback para inicio de sesión
    func playSessionStart() {
        guard isHapticEnabled else { return }
        notificationGenerator.notificationOccurred(.success)
        
        // Preparar para la sesión
        prepareGenerators()
    }
    
    /// Feedback para fin de sesión
    func playSessionEnd() {
        guard isHapticEnabled else { return }
        impactMedium.impactOccurred()
    }
    
    /// Feedback para ciclo completado (celebración)
    func playCycleCompleted() {
        guard isHapticEnabled else { return }
        
        // Patrón de celebración: tres pulsos rápidos
        impactMedium.impactOccurred()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            self?.impactMedium.impactOccurred()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
            self?.notificationGenerator.notificationOccurred(.success)
        }
    }
    
    /// Feedback para guardar sesión exitosamente
    func playSessionSaved() {
        guard isHapticEnabled else { return }
        notificationGenerator.notificationOccurred(.success)
    }
    
    // MARK: - Haptics para Interacciones UI
    
    /// Feedback para selección de elemento (suave)
    func playSelection() {
        guard isHapticEnabled else { return }
        selectionGenerator.selectionChanged()
    }
    
    /// Feedback para botón de acción importante
    func playButtonTap() {
        guard isHapticEnabled else { return }
        impactMedium.impactOccurred()
    }
    
    /// Feedback para botón de acción ligera
    func playLightButtonTap() {
        guard isHapticEnabled else { return }
        impactLight.impactOccurred()
    }
    
    /// Feedback para error
    func playError() {
        guard isHapticEnabled else { return }
        notificationGenerator.notificationOccurred(.error)
    }
    
    /// Feedback para warning
    func playWarning() {
        guard isHapticEnabled else { return }
        notificationGenerator.notificationOccurred(.warning)
    }
    
    // MARK: - Haptic Patterns Avanzados
    
    /// Patrón de respiración progresivo (para transiciones suaves)
    func playProgressivePattern(duration: TimeInterval, intensity: CGFloat = 1.0) {
        guard isHapticEnabled else { return }
        
        let steps = 5
        let stepDuration = duration / Double(steps)
        
        for i in 0..<steps {
            let delay = Double(i) * stepDuration
            let stepIntensity = intensity * (CGFloat(i + 1) / CGFloat(steps))
            
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
                self?.impactLight.impactOccurred(intensity: stepIntensity)
            }
        }
    }
    
    /// Patrón de latido (para fases de hold)
    func playHeartbeatPattern() {
        guard isHapticEnabled else { return }
        
        impactLight.impactOccurred(intensity: 0.5)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) { [weak self] in
            self?.impactLight.impactOccurred(intensity: 0.7)
        }
    }
}

// MARK: - Convenience Extensions
extension HapticManager {
    /// Toggle del estado de hápticos con feedback
    func toggleHaptic() {
        isHapticEnabled.toggle()
        
        // Dar feedback del nuevo estado
        if isHapticEnabled {
            playSelection()
        }
    }
}
#else
// Versión stub para plataformas sin UIKit
@Observable
class HapticManager {
    var isHapticEnabled: Bool = false
    
    init() {}
    func playPhaseHaptic(for type: BreathPhaseType) {}
    func playSessionStart() {}
    func playSessionEnd() {}
    func playCycleCompleted() {}
    func playSessionSaved() {}
    func playSelection() {}
    func playButtonTap() {}
    func playLightButtonTap() {}
    func playError() {}
    func playWarning() {}
    func toggleHaptic() {}
}
#endif

