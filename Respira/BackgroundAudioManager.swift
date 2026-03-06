//
//  BackgroundAudioManager.swift
//  Respira
//
//  Created by Amada Hernández Borges on 3/8/26.
//

import Foundation
import MediaPlayer
import AVFoundation

/// Manager para controlar el audio en background y los controles del centro de control
@Observable
class BackgroundAudioManager {
    
    // MARK: - Singleton
    static let shared = BackgroundAudioManager()
    
    private init() {
        setupRemoteCommands()
        setupAudioSessionNotifications()
    }
    
    // MARK: - Now Playing Info
    
    /// Actualiza la información mostrada en el centro de control
    func updateNowPlayingInfo(
        patternName: String,
        phaseName: String,
        duration: TimeInterval,
        elapsedTime: TimeInterval = 0
    ) {
        var nowPlayingInfo = [String: Any]()
        
        // Título (nombre del patrón)
        nowPlayingInfo[MPMediaItemPropertyTitle] = patternName
        
        // Artista (fase actual)
        nowPlayingInfo[MPMediaItemPropertyArtist] = phaseName
        
        // Álbum
        nowPlayingInfo[MPMediaItemPropertyAlbumTitle] = "Respira"
        
        // Duración
        nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = duration
        nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = elapsedTime
        
        // Velocidad de reproducción
        nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = 1.0
        
        // Artwork (icono de la app)
        if let image = createBreathingIcon() {
            let artwork = MPMediaItemArtwork(boundsSize: image.size) { _ in image }
            nowPlayingInfo[MPMediaItemPropertyArtwork] = artwork
        }
        
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
    }
    
    /// Limpia la información del centro de control
    func clearNowPlayingInfo() {
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nil
    }
    
    // MARK: - Remote Commands
    
    private func setupRemoteCommands() {
        let commandCenter = MPRemoteCommandCenter.shared()
        
        // Play
        commandCenter.playCommand.isEnabled = false
        
        // Pause
        commandCenter.pauseCommand.isEnabled = false
        
        // Stop
        commandCenter.stopCommand.isEnabled = false
        
        // Next/Previous (deshabilitados para respiración)
        commandCenter.nextTrackCommand.isEnabled = false
        commandCenter.previousTrackCommand.isEnabled = false
        
        print("✅ Remote commands configurados")
    }
    
    // MARK: - Audio Session Notifications
    
    private func setupAudioSessionNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleInterruption),
            name: AVAudioSession.interruptionNotification,
            object: AVAudioSession.sharedInstance()
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleRouteChange),
            name: AVAudioSession.routeChangeNotification,
            object: AVAudioSession.sharedInstance()
        )
    }
    
    @objc private func handleInterruption(notification: Notification) {
        guard let userInfo = notification.userInfo,
              let typeValue = userInfo[AVAudioSessionInterruptionTypeKey] as? UInt,
              let type = AVAudioSession.InterruptionType(rawValue: typeValue) else {
            return
        }
        
        switch type {
        case .began:
            // La sesión de audio fue interrumpida (llamada, alarma, etc.)
            print("⚠️ Audio interrumpido")
            NotificationCenter.default.post(name: .audioInterrupted, object: nil)
            
        case .ended:
            // La interrupción terminó
            guard let optionsValue = userInfo[AVAudioSessionInterruptionOptionKey] as? UInt else {
                return
            }
            
            let options = AVAudioSession.InterruptionOptions(rawValue: optionsValue)
            if options.contains(.shouldResume) {
                print("✅ Audio puede resumir")
                NotificationCenter.default.post(name: .audioCanResume, object: nil)
            }
            
        @unknown default:
            break
        }
    }
    
    @objc private func handleRouteChange(notification: Notification) {
        guard let userInfo = notification.userInfo,
              let reasonValue = userInfo[AVAudioSessionRouteChangeReasonKey] as? UInt,
              let reason = AVAudioSession.RouteChangeReason(rawValue: reasonValue) else {
            return
        }
        
        switch reason {
        case .oldDeviceUnavailable:
            // Auriculares desconectados
            print("⚠️ Auriculares desconectados")
            NotificationCenter.default.post(name: .audioDeviceDisconnected, object: nil)
            
        default:
            break
        }
    }
    
    // MARK: - Helper Methods
    
    private func createBreathingIcon() -> UIImage? {
        // Crear un icono simple para el centro de control
        let size = CGSize(width: 200, height: 200)
        let renderer = UIGraphicsImageRenderer(size: size)
        
        let image = renderer.image { context in
            // Fondo degradado azul
            let colors = [UIColor.systemBlue.cgColor, UIColor.systemTeal.cgColor]
            let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(),
                                     colors: colors as CFArray,
                                     locations: [0, 1])!
            
            context.cgContext.drawLinearGradient(
                gradient,
                start: CGPoint(x: 0, y: 0),
                end: CGPoint(x: size.width, y: size.height),
                options: []
            )
            
            // Círculo blanco en el centro (representa respiración)
            let circlePath = UIBezierPath(
                ovalIn: CGRect(x: 50, y: 50, width: 100, height: 100)
            )
            UIColor.white.setFill()
            circlePath.fill()
        }
        
        return image
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - Notification Names

extension Notification.Name {
    static let audioInterrupted = Notification.Name("audioInterrupted")
    static let audioCanResume = Notification.Name("audioCanResume")
    static let audioDeviceDisconnected = Notification.Name("audioDeviceDisconnected")
}
