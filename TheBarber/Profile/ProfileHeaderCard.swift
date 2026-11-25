//
//  ProfileHeaderCard.swift
//  TheBarber
//
//  Created by Jaloliddin Esonboyev on 25/11/2026.
//

import SwiftUI

struct ProfileHeaderCard: View {
    let profile: UserProfile
    let onEditTapped: () -> Void
    let onRegisterTapped: () -> Void
    
    var body: some View {
        HStack(spacing: 16) {
            avatarView
                .frame(width: 64, height: 64)
            
            VStack(alignment: .leading, spacing: 4) {
                if profile.isRegistered {
                    Text(profile.name)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                    
                    Text(profile.phone)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                } else {
                    Text("Guest User")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                    
                    Text("Sign in to sync your bookings")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            
            Spacer()
            
            Button(action: profile.isRegistered ? onEditTapped : onRegisterTapped) {
                Text(profile.isRegistered ? "Edit" : "Sign In")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.blue)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 6)
                    .background(Color.blue.opacity(0.1))
                    .clipShape(Capsule())
            }
        }
        .padding(.vertical, 4)
    }
    
    @ViewBuilder
    private var avatarView: some View {
        if let data = profile.avatarData, let uiImage = UIImage(data: data) {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFill()
                .clipShape(Circle())
        } else {
            ZStack {
                Circle()
                    .fill(Color(.systemGray5))
                
                if profile.isRegistered {
                    Text(profile.initials)
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.secondary)
                } else {
                    Image(systemName: "person.fill")
                        .font(.title2)
                        .foregroundColor(.secondary)
                }
            }
        }
    }
}

#Preview {
    List {
        ProfileHeaderCard(
            profile: UserProfile(
                name: "Jaloliddin Esonboyev",
                phone: "+48 123 456 789",
                avatarData: nil,
                isRegistered: true
            ),
            onEditTapped: {},
            onRegisterTapped: {}
        )
    }
}

