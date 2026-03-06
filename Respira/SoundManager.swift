//
//
//  SoundManager.swift
//  Respira
//
//  Created by Amada Hernández Borges on 3/6/26.
//

import AVFoundation
import SwiftUI

@Observable
class SoundManager {
    private var audioPlayers: [String: AVAudioPlayer] = [:]
    var isSoundEnabled: Bool {
        didSet {
            UserDefaults.standard.set(isSoundEnabled, forKey: "isSoundEnabled")
        }
    }
    var currentPreset: SoundPreset {
        didSet {
            // Guardar preferencia
            UserDefaults.standard.set(currentPreset.id, forKey: "soundPresetID")
            // Regenerar sonidos cuando cambia el preset
            generateSoundsForPreset(currentPreset)
        }
    }
    
    init() {
        // Cargar preferencias guardadas
        self.isSoundEnabled = UserDefaults.standard.bool(forKey: "isSoundEnabled")
        
        // Si es la primera vez (default false), activar sonido
        if UserDefaults.standard.object(forKey: "isSoundEnabled") == nil {
            self.isSoundEnabled = true
        }
        
        // Cargar preset guardado o usar default
        if let savedPresetID = UserDefaults.standard.string(forKey: "soundPresetID"),
           let preset = SoundPreset.allPresets.first(where: { $0.id == savedPresetID }) {
            self.currentPreset = preset
        } else {
            self.currentPreset = .bell
        }
        
        setupAudioSession()
        generateSoundsForPreset(currentPreset)
    }
    
    private func setupAudioSession() {
        do {
            // Configurar para reproducción en background
            let audioSession = AVAudioSession.sharedInstance()
            
            // .playback permite audio en background
            // .mixWithOthers permite que otros sonidos se reproduzcan simultáneamente
            try audioSession.setCategory(.playback, mode: .default, options: [.mixWithOthers])
            
            // Activar la sesión
            try audioSession.setActive(true)
            
            print("✅ Audio configurado para background")
        } catch {
            print("❌ Error configurando sesión de audio: \(error)")
        }
    }
    
    private func generateSoundsForPreset(_ preset: SoundPreset) {
        // Limpiar sonidos anteriores
        audioPlayers.removeAll()
        
        // Generamos tonos para cada fase usando el preset actual
        createTone(name: "inhale", frequency: 440.0, duration: 1.2, preset: preset)   // Tono A (la)
        createTone(name: "hold", frequency: 523.25, duration: 1.0, preset: preset)    // Tono C (do)
        createTone(name: "exhale", frequency: 349.23, duration: 1.2, preset: preset)  // Tono F (fa)
        createTone(name: "pause", frequency: 293.66, duration: 1.0, preset: preset)   // Tono D (re)
    }
    
    private func createTone(name: String, frequency: Double, duration: Double, preset: SoundPreset) {
        let sampleRate = 44100.0
        let samples = Int(sampleRate * duration)
        
        var audioData = Data()
        
        for i in 0..<samples {
            let time = Double(i) / sampleRate
            var sample = 0.0
            
            // Sumar todos los armónicos del preset
            for harmonic in preset.harmonics {
                let harmonicFreq = frequency * harmonic.frequencyMultiplier
                sample += sin(2.0 * .pi * harmonicFreq * time) * harmonic.amplitude
            }
            
            // Normalizar
            sample = sample / Double(preset.harmonics.count) * preset.baseAmplitude
            
            // Aplicar envolvente del preset
            var envelope = 1.0
            if time < preset.envelope.attackTime {
                // Ataque suave
                envelope = time / preset.envelope.attackTime
            } else {
                // Decaimiento exponencial
                envelope = exp(-preset.envelope.decayRate * (time - preset.envelope.attackTime))
            }
            
            let finalSample = Int16(sample * envelope * 32767.0)
            audioData.append(contentsOf: withUnsafeBytes(of: finalSample.littleEndian) { Array($0) })
        }
        
        // Crear archivo temporal
        let tempURL = FileManager.default.temporaryDirectory.appendingPathComponent("\(name).wav")
        
        // Escribir header WAV
        if let wavData = createWAVData(from: audioData, sampleRate: Int(sampleRate)) {
            do {
                try wavData.write(to: tempURL)
                let player = try AVAudioPlayer(contentsOf: tempURL)
                player.prepareToPlay()
                audioPlayers[name] = player
            } catch {
                print("Error creando audio para \(name): \(error)")
            }
        }
    }
    
    private func createWAVData(from pcmData: Data, sampleRate: Int) -> Data? {
        var wavData = Data()
        
        // RIFF header
        wavData.append(contentsOf: "RIFF".utf8)
        let fileSize = UInt32(36 + pcmData.count)
        wavData.append(contentsOf: withUnsafeBytes(of: fileSize.littleEndian) { Array($0) })
        wavData.append(contentsOf: "WAVE".utf8)
        
        // fmt chunk
        wavData.append(contentsOf: "fmt ".utf8)
        let fmtSize = UInt32(16)
        wavData.append(contentsOf: withUnsafeBytes(of: fmtSize.littleEndian) { Array($0) })
        let audioFormat = UInt16(1) // PCM
        wavData.append(contentsOf: withUnsafeBytes(of: audioFormat.littleEndian) { Array($0) })
        let numChannels = UInt16(1) // Mono
        wavData.append(contentsOf: withUnsafeBytes(of: numChannels.littleEndian) { Array($0) })
        let sampleRateValue = UInt32(sampleRate)
        wavData.append(contentsOf: withUnsafeBytes(of: sampleRateValue.littleEndian) { Array($0) })
        let byteRate = UInt32(sampleRate * 2) // sampleRate * numChannels * bitsPerSample/8
        wavData.append(contentsOf: withUnsafeBytes(of: byteRate.littleEndian) { Array($0) })
        let blockAlign = UInt16(2) // numChannels * bitsPerSample/8
        wavData.append(contentsOf: withUnsafeBytes(of: blockAlign.littleEndian) { Array($0) })
        let bitsPerSample = UInt16(16)
        wavData.append(contentsOf: withUnsafeBytes(of: bitsPerSample.littleEndian) { Array($0) })
        
        // data chunk
        wavData.append(contentsOf: "data".utf8)
        let dataSize = UInt32(pcmData.count)
        wavData.append(contentsOf: withUnsafeBytes(of: dataSize.littleEndian) { Array($0) })
        wavData.append(pcmData)
        
        return wavData
    }
    
    func playSound(for phaseType: BreathPhaseType) {
        guard isSoundEnabled else { return }
        
        if let player = audioPlayers[phaseType.soundName] {
            player.currentTime = 0
            player.play()
        }
    }
    
    func playSuccessSound() {
        guard isSoundEnabled else { return }
        // Reproducir un patrón de sonidos para indicar ciclo completado
        playSound(for: .inhale)
    }
}
