//
//  PrimaryButton.swift
//  TheBarber
//
//  Created by Jaloliddin Esonboyev on 26/11/2026.
//

import SwiftUI

struct PrimaryButton: View {
    let title: String
    var isEnabled: Bool = true
    var isLoading: Bool = false
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack {
                if isLoading {
                    ProgressView()
                        .tint(.white)
                } else {
                    Text(title)
                        .font(.headline)
                        .bold()
                }
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 52)
            .background(isEnabled ? Color.blue : Color.blue.opacity(0.4))
            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
        }
        .disabled(!isEnabled || isLoading)
    }
}

struct SecondaryButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .bold()
                .foregroundColor(.primary)
                .frame(maxWidth: .infinity)
                .frame(height: 52)
                .background(Color(.systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
        }
    }
}

struct CancelButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .bold()
                .foregroundColor(.red)
                .frame(maxWidth: .infinity)
                .frame(height: 52)
                .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(.red, lineWidth: 1)
                )
        }
    }
}

#Preview("App Buttons") {
    VStack(spacing: 16) {
        PrimaryButton(title: "Continue (Enabled)", isEnabled: true) {}
        
        PrimaryButton(title: "Continue (Disabled)", isEnabled: false) {}
        
        PrimaryButton(title: "Continue (Loading)", isEnabled: true, isLoading: true) {}
        
        SecondaryButton(title: "Skip") {}
        
        CancelButton(title: "Cancel") {}
    }
    .padding()
}
