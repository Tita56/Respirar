//
//  PatternSelectionView.swift
//  Respira
//
//  Created by Amada Hernández Borges on 3/6/26.
//

import SwiftUI

struct PatternSelectionView: View {
    @Binding var selectedPattern: BreathingPattern
    @Environment(\.dismiss) private var dismiss
    @State private var hapticManager = HapticManager()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(BreathingPattern.patterns) { pattern in
                        PatternCard(
                            pattern: pattern,
                            isSelected: pattern == selectedPattern
                        ) {
                            hapticManager.playSelection()
                            selectedPattern = pattern
                            dismiss()
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Patrones de Respiración")
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

struct PatternCard: View {
    let pattern: BreathingPattern
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Image(systemName: pattern.icon)
                        .font(.system(size: 30))
                        .foregroundColor(isSelected ? .white : .blue)
                        .frame(width: 50, height: 50)
                        .background(isSelected ? Color.blue : Color.blue.opacity(0.1))
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(pattern.name)
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        Text(pattern.description)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.leading)
                    }
                    
                    Spacer()
                    
                    if isSelected {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.title2)
                            .foregroundColor(.blue)
                    }
                }
                
                // Mostrar las fases del patrón
                HStack(spacing: 8) {
                    ForEach(Array(pattern.phases.enumerated()), id: \.offset) { index, phase in
                        HStack(spacing: 4) {
                            Circle()
                                .fill(phase.type.color)
                                .frame(width: 8, height: 8)
                            Text("\(Int(phase.duration))s")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        
                        if index < pattern.phases.count - 1 {
                            Image(systemName: "arrow.right")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            .padding()
            .background(isSelected ? Color.blue.opacity(0.1) : Color(.systemBackground))
            .cornerRadius(15)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(isSelected ? Color.blue : Color.gray.opacity(0.2), lineWidth: isSelected ? 2 : 1)
            )
            .shadow(color: isSelected ? Color.blue.opacity(0.3) : Color.clear, radius: 8)
        }
        .buttonStyle(.plain)
    }
}
