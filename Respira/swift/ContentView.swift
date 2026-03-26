//
//  ContentView.swift
//  Respira
//
//  Created by Amada Hernández Borges on 2/16/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    
    // Estados para controlar la animación
    @State private var isBreathingIn = false
    @State private var isActive = false
    @State private var currentPhaseIndex = 0
    @State private var cycleCount = 0
    @State private var showInstructions = false
    @State private var showPatternSelection = false
    @State private var showSoundPresetSelection = false
    @State private var selectedPattern = BreathingPattern.patterns[0]
    @State private var soundManager = SoundManager()
    @State private var hapticManager = HapticManager()
    @State private var sessionStartTime: Date?
    @State private var showSessionSaved = false
    
    private var currentPhase: BreathPhase {
        guard !selectedPattern.phases.isEmpty else {
            return BreathPhase(type: .pause, duration: 1.0)
        }
        return selectedPattern.phases[currentPhaseIndex % selectedPattern.phases.count]
    }
    
    var body: some View {
        ZStack {
            // Fondo degradado
            LinearGradient(
                gradient: Gradient(colors: [
                    currentPhase.type.color.opacity(0.3),
                    currentPhase.type.color.opacity(0.1)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack(spacing: 20) {
                // Encabezado con título y controles
                HStack {
                    VStack(alignment: .leading) {
                        Text("Control de Respiración")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(currentPhase.type.color)
                        
                        Button(action: {
                            showPatternSelection = true
                        }) {
                            HStack {
                                Image(systemName: selectedPattern.icon)
                                Text(selectedPattern.name)
                                Image(systemName: "chevron.right")
                            }
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        }
                        .disabled(isActive)
                    }
                    
                    Spacer()
                    
                    // Controles de sonido
                    HStack(spacing: 12) {
                        // Botón de preset de sonido
                        Button(action: {
                            showSoundPresetSelection = true
                        }) {
                            Image(systemName: soundManager.currentPreset.icon)
                                .font(.title3)
                                .foregroundColor(.blue)
                                .frame(width: 44, height: 44)
                                .background(Color(.systemBackground))
                                .clipShape(Circle())
                                .shadow(radius: 2)
                        }
                        
                        // Botón de activar/desactivar sonido
                        Button(action: {
                            soundManager.isSoundEnabled.toggle()
                        }) {
                            Image(systemName: soundManager.isSoundEnabled ? "speaker.wave.3.fill" : "speaker.slash.fill")
                                .font(.title2)
                                .foregroundColor(soundManager.isSoundEnabled ? .blue : .gray)
                                .frame(width: 44, height: 44)
                                .background(Color(.systemBackground))
                                .clipShape(Circle())
                                .shadow(radius: 2)
                        }
                    }
                }
                
                Spacer()
                
                // Círculo de respiración animado
                ZStack {
                    // Círculo exterior (efecto de glow)
                    Circle()
                        .fill(currentPhase.type.color.opacity(0.3))
                        .frame(width: isBreathingIn ? 360 : 220)
                        .blur(radius: 25)
                    
                    // Círculo principal
                    Circle()
                        .fill(
                            RadialGradient(
                                gradient: Gradient(colors: [
                                    currentPhase.type.color.opacity(0.8),
                                    currentPhase.type.color.opacity(0.4)
                                ]),
                                center: .center,
                                startRadius: 30,
                                endRadius: 180
                            )
                        )
                        .frame(width: isBreathingIn ? 340 : 200)
                        .shadow(color: currentPhase.type.color.opacity(0.5), radius: 25)
                    
                    // Tiempo restante en el centro
                    VStack(spacing: 12) {
                        if isActive {
                            Text("\(Int(currentPhase.duration))")
                                .font(.system(size: 72, weight: .ultraLight, design: .rounded))
                                .foregroundColor(.white)
                                .monospacedDigit()
                        }
                    }
                }
                .animation(.easeInOut(duration: currentPhase.duration), value: isBreathingIn)
                .animation(.easeInOut(duration: 0.5), value: currentPhase.type)
                
                // Instrucciones
                VStack(spacing: 8) {
                    Text(currentPhase.type.instruction)
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                    
                    if isActive {
                        Text("Ciclo: \(cycleCount)")
                            .font(.title3)
                            .foregroundColor(.secondary)
                    }
                }
                .frame(height: 100)
                
                Spacer()
                
                // Botones de control
                HStack(spacing: 30) {
                    Button(action: {
                        if isActive {
                            stopBreathing()
                        } else {
                            startBreathing()
                        }
                    }) {
                        Label(
                            isActive ? "Detener" : "Comenzar",
                            systemImage: isActive ? "stop.circle.fill" : "play.circle.fill"
                        )
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.gray)
                        .cornerRadius(15)
                        .shadow(radius: 5)
                    }
                    
                    Button(action: {
                        resetBreathing()
                    }) {
                        Image(systemName: "arrow.counterclockwise.circle.fill")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.gray)
                            .cornerRadius(15)
                            .shadow(radius: 5)
                    }
                }
                .padding(.bottom, 30)
            }
            .padding()
            
            // Instrucciones iniciales
            if showInstructions && !isActive {
                VStack(spacing: 20) {
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 15) {
                        HStack {
                            Image(systemName: "info.circle.fill")
                                .font(.title2)
                                .foregroundColor(.blue)
                            Text("Bienvenido a RespiraApp")
                                .font(.headline)
                                .foregroundColor(.primary)
                        }
                        
                        Text("Esta app te ayudará a practicar diferentes técnicas de respiración para:")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Label("Reducir estrés y ansiedad", systemImage: "heart.fill")
                            Label("Mejorar concentración", systemImage: "brain.head.profile")
                            Label("Facilitar el sueño", systemImage: "moon.fill")
                            Label("Aumentar energía", systemImage: "bolt.fill")
                        }
                        .font(.subheadline)
                        .foregroundColor(.primary)
                        
                        Text("Elige un patrón arriba y presiona Comenzar")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .padding(.top, 4)
                        
                        Button("Entendido") {
                            withAnimation {
                                showInstructions = false
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.blue)
                        .cornerRadius(10)
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(20)
                    .shadow(radius: 20)
                    .padding()
                }
            }
        }
        .sheet(isPresented: $showPatternSelection) {
            PatternSelectionView(selectedPattern: $selectedPattern)
        }
        .sheet(isPresented: $showSoundPresetSelection) {
            SoundPresetSelectionView(selectedPreset: $soundManager.currentPreset)
        }
        .onChange(of: selectedPattern) { _, _ in
            resetBreathing()
        }
        .overlay(alignment: .top) {
            if showSessionSaved {
                SessionSavedBanner()
                    .transition(.move(edge: .top).combined(with: .opacity))
                    .padding(.top, 50)
            }
        }
        .onAppear {
            checkForWidgetAction()
        }
    }
    
    // MARK: - Widget Integration
    func checkForWidgetAction() {
        let defaults = UserDefaults()
        if let patternName = defaults.string(forKey: "selectedPatternFromWidget") {
            // Buscar el patrón seleccionado
            if let pattern = BreathingPattern.patterns.first(where: { $0.name == patternName }) {
                selectedPattern = pattern
                
                // Iniciar automáticamente si no está activo
                if !isActive {
                    // Pequeño delay para que la UI se actualice
                    Task {
                        try? await Task.sleep(nanoseconds: 500_000_000)
                        startBreathing()
                    }
                }
            }
            
            // Limpiar el flag
            defaults.removeObject(forKey: "selectedPatternFromWidget")
            defaults.synchronize()
        }
    }
    
    // Funciones de control
    func startBreathing() {
        isActive = true
        currentPhaseIndex = 0
        cycleCount = 1
        sessionStartTime = Date()
        
        // Feedback háptico de inicio
        hapticManager.playSessionStart()
        
        animateBreathCycle()
    }
    
    func stopBreathing() {
        isActive = false
        isBreathingIn = false
        
        // Feedback háptico de fin de sesión
        hapticManager.playSessionEnd()
        
        // Limpiar información del centro de control
        BackgroundAudioManager.shared.clearNowPlayingInfo()
        
        saveSession()
    }
    
    func resetBreathing() {
        isActive = false
        isBreathingIn = false
        currentPhaseIndex = 0
        cycleCount = 0
        sessionStartTime = nil
        
        // Limpiar información del centro de control
        BackgroundAudioManager.shared.clearNowPlayingInfo()
        
        // Feedback háptico suave para reset
        hapticManager.playLightButtonTap()
    }
    
    func saveSession() {
        guard let startTime = sessionStartTime, cycleCount > 0 else { return }
        
        let duration = Date().timeIntervalSince(startTime)
        
        let session = BreathingSession(
            patternName: selectedPattern.name,
            patternIcon: selectedPattern.icon,
            cyclesCompleted: cycleCount,
            durationSeconds: duration
        )
        
        modelContext.insert(session)
        
        // Intentar guardar
        do {
            try modelContext.save()
            
            // Feedback háptico de guardado exitoso
            hapticManager.playSessionSaved()
            
            // Actualizar datos del widget
            Task { @MainActor in
                let descriptor = FetchDescriptor<BreathingSession>(
                    sortBy: [SortDescriptor(\.date, order: .reverse)]
                )
                if let allSessions = try? modelContext.fetch(descriptor) {
                    let stats = BreathingSession.calculateStats(from: allSessions)
                    //WidgetDataManager.shared.updateWidgetData(stats: stats)
                }
            }
            
            // Mostrar banner de confirmación
            withAnimation {
                showSessionSaved = true
            }
            
            // Ocultar después de 3 segundos
            Task {
                try? await Task.sleep(nanoseconds: 3_000_000_000)
                withAnimation {
                    showSessionSaved = false
                }
            }
        } catch {
            print("Error guardando sesión: \(error)")
            hapticManager.playError()
        }
        
        sessionStartTime = nil
    }
    
    func animateBreathCycle() {
        guard isActive else { return }
        
        let phase = currentPhase
        
        // Reproducir sonido al iniciar la fase
        soundManager.playSound(for: phase.type)
        
        // Reproducir feedback háptico para la fase
        hapticManager.playPhaseHaptic(for: phase.type)
        
        // Actualizar información de "Now Playing" en el centro de control
        let elapsedTime = sessionStartTime.map { Date().timeIntervalSince($0) } ?? 0
        BackgroundAudioManager.shared.updateNowPlayingInfo(
            patternName: selectedPattern.name,
            phaseName: phase.type.instruction,
            duration: phase.duration,
            elapsedTime: elapsedTime
        )
        
        // Animar según el tipo de fase
        if phase.type == .inhale {
            isBreathingIn = true
        } else if phase.type == .exhale {
            isBreathingIn = false
        }
        
        // Esperar la duración de la fase
        Task {
            try? await Task.sleep(nanoseconds: UInt64(phase.duration * 1_000_000_000))
            
            guard isActive else { return }
            
            // Avanzar a la siguiente fase
            currentPhaseIndex += 1
            
            // Si completamos todas las fases, incrementar el ciclo
            if currentPhaseIndex % selectedPattern.phases.count == 0 {
                cycleCount += 1
                soundManager.playSuccessSound()
                
                // Feedback háptico especial para ciclo completado
                hapticManager.playCycleCompleted()
            }
            
            animateBreathCycle()
        }
    }
}

// MARK: - Session Saved Banner
struct SessionSavedBanner: View {
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "checkmark.circle.fill")
                .font(.title3)
                .foregroundStyle(.green)
            
            Text("Sesión guardada")
                .font(.subheadline)
                .fontWeight(.medium)
        }
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: .black.opacity(0.1), radius: 8)
        .padding(.horizontal)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: BreathingSession.self, inMemory: true)
}

