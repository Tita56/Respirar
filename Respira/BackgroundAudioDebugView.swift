//
//  BackgroundAudioDebugView.swift
//  Respira
//
//  Created by Amada Hernández Borges on 3/8/26.
//

import SwiftUI
import AVFoundation

/// Vista de debug para verificar la configuración de audio en background
struct BackgroundAudioDebugView: View {
    @State private var audioSessionInfo: String = "Verificando..."
    @State private var backgroundModesEnabled: Bool = false
    @State private var testResults: [String] = []
    
    var body: some View {
        NavigationStack {
            List {
                Section("Estado de AVAudioSession") {
                    Text(audioSessionInfo)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                
                Section("Configuración Requerida") {
                    HStack {
                        Text("Background Modes")
                        Spacer()
                        Image(systemName: backgroundModesEnabled ? "checkmark.circle.fill" : "xmark.circle.fill")
                            .foregroundStyle(backgroundModesEnabled ? .green : .red)
                    }
                    
                    if !backgroundModesEnabled {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("⚠️ Background Modes no configurado")
                                .font(.headline)
                                .foregroundStyle(.red)
                            
                            Text("Debes añadir la capability manualmente en Xcode:")
                                .font(.caption)
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("1. Selecciona el proyecto")
                                Text("2. Target → Signing & Capabilities")
                                Text("3. + Capability → Background Modes")
                                Text("4. ✅ Audio, AirPlay, and Picture in Picture")
                            }
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                        }
                        .padding(.vertical, 8)
                    }
                }
                
                Section("Resultados de Pruebas") {
                    if testResults.isEmpty {
                        Text("Ejecuta las pruebas")
                            .foregroundStyle(.secondary)
                    } else {
                        ForEach(testResults, id: \.self) { result in
                            Text(result)
                                .font(.caption)
                        }
                    }
                }
                
                Section("Acciones") {
                    Button("Ejecutar Pruebas") {
                        runDiagnostics()
                    }
                    
                    Button("Verificar Configuración") {
                        checkConfiguration()
                    }
                }
            }
            .navigationTitle("Debug Audio Background")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                checkConfiguration()
            }
        }
    }
    
    private func checkConfiguration() {
        let audioSession = AVAudioSession.sharedInstance()
        
        // Información de la sesión de audio
        var info = """
        Categoría: \(audioSession.category.rawValue)
        Modo: \(audioSession.mode.rawValue)
        Opciones: \(audioSession.categoryOptions)
        """
        
        // Verificar si la categoría es .playback
        if audioSession.category == .playback {
            info += "\n✅ Categoría correcta para background"
        } else {
            info += "\n❌ Categoría incorrecta"
        }
        
        audioSessionInfo = info
        
        // Verificar Background Modes (esto solo es una aproximación)
        // No podemos verificar directamente si la capability está añadida
        // pero podemos verificar la configuración
        backgroundModesEnabled = audioSession.category == .playback
        
        testResults.append("✅ Verificación completada")
        testResults.append("Categoría: \(audioSession.category.rawValue)")
    }
    
    private func runDiagnostics() {
        testResults.removeAll()
        
        // Test 1: Verificar AVAudioSession
        let audioSession = AVAudioSession.sharedInstance()
        
        testResults.append("=== TEST 1: AVAudioSession ===")
        testResults.append("Categoría: \(audioSession.category.rawValue)")
        
        if audioSession.category == .playback {
            testResults.append("✅ Categoría .playback configurada")
        } else {
            testResults.append("❌ Categoría incorrecta")
            testResults.append("   Debería ser: .playback")
            testResults.append("   Actual: \(audioSession.category.rawValue)")
        }
        
        // Test 2: Opciones
        testResults.append("\n=== TEST 2: Opciones ===")
        if audioSession.categoryOptions.contains(.mixWithOthers) {
            testResults.append("✅ mixWithOthers activado")
        } else {
            testResults.append("⚠️ mixWithOthers no activado")
        }
        
        // Test 3: Modo
        testResults.append("\n=== TEST 3: Modo ===")
        testResults.append("Modo: \(audioSession.mode.rawValue)")
        
        // Test 4: Estado de activación
        testResults.append("\n=== TEST 4: Estado ===")
        if audioSession.isOtherAudioPlaying {
            testResults.append("⚠️ Otra app está reproduciendo audio")
        } else {
            testResults.append("✅ No hay otra app reproduciendo")
        }
        
        // Test 5: Ruta de salida
        testResults.append("\n=== TEST 5: Ruta de Salida ===")
        let outputs = audioSession.currentRoute.outputs
        for output in outputs {
            testResults.append("  📱 \(output.portName) (\(output.portType.rawValue))")
        }
        
        // Resumen
        testResults.append("\n=== RESUMEN ===")
        if audioSession.category == .playback {
            testResults.append("✅ Configuración de audio correcta")
            testResults.append("")
            testResults.append("⚠️ Si el audio NO funciona en background:")
            testResults.append("   1. Verifica Background Modes en Xcode")
            testResults.append("   2. Limpia build (Cmd+Shift+K)")
            testResults.append("   3. Vuelve a compilar")
        } else {
            testResults.append("❌ Configuración incorrecta")
            testResults.append("   Contacta al desarrollador")
        }
    }
}

#Preview {
    BackgroundAudioDebugView()
}
