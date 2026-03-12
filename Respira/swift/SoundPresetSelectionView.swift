//
//  SoundPresetSelectionView.swift
//  Respira
//
//  Created by Amada Hernández Borges on 3/8/26.
//

import SwiftUI

struct SoundPresetSelectionView: View {
    @Binding var selectedPreset: SoundPreset
    @Environment(\.dismiss) private var dismiss
    @State private var hapticManager = HapticManager()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(SoundPreset.allPresets) { preset in
                    PresetRow(
                        preset: preset,
                        isSelected: selectedPreset.id == preset.id
                    )
                    .contentShape(Rectangle())
                    .onTapGesture {
                        hapticManager.playSelection()
                        selectedPreset = preset
                        dismiss()
                    }
                }
            }
            .navigationTitle("Sonido")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cerrar") {
                        hapticManager.playLightButtonTap()
                        dismiss()
                    }
                }
            }
        }
    }
}

struct PresetRow: View {
    let preset: SoundPreset
    let isSelected: Bool
    
    var body: some View {
        HStack(spacing: 16) {
            // Icono del preset
            Image(systemName: preset.icon)
                .font(.title2)
                .foregroundStyle(isSelected ? .blue : .secondary)
                .frame(width: 40)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(preset.name)
                    .font(.headline)
                
                Text(preset.description)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
            }
            
            Spacer()
            
            // Checkmark si está seleccionado
            if isSelected {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundStyle(.blue)
                    .font(.title3)
            }
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    SoundPresetSelectionView(selectedPreset: .constant(.bell))
}
