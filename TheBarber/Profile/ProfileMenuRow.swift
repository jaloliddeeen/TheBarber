//
//  ProfileMenuRow.swift
//  TheBarber
//
//  Created by Jaloliddin Esonboyev on 25/11/2026.
//

import SwiftUI

struct ProfileMenuRow: View {
    let icon: String
    let iconColor: Color
    let title: String
    var badge: String? = nil
    
    var body: some View {
        HStack(spacing: 14) {
            ZStack {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(iconColor.opacity(0.15))
                    .frame(width: 32, height: 32)
                
                Image(systemName: icon)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(iconColor)
            }
            
            Text(title)
                .font(.body)
                .foregroundColor(.primary)
            
            Spacer()
            
            if let badge = badge {
                Text(badge)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }
}

#Preview {
    ProfileMenuRow(icon: "bell", iconColor: Color.pink, title: "Something")
}
