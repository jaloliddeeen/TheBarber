//
//  ProfileView.swift
//  TheBarber
//
//  Created by Jaloliddin Esonboyev on 25/11/2026.
//

import SwiftUI

struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    if !viewModel.userProfile.isRegistered {
                        Button(action: {
                            viewModel.showRegisterSheet = true
                        }) {
                            HStack(spacing: 16) {
                                ZStack {
                                    Circle()
                                        .fill(Color.blue.opacity(0.12))
                                        .frame(width: 64, height: 64)
                                    
                                    Image(systemName: "person.crop.circle.badge.plus")
                                        .font(.title2)
                                        .foregroundColor(.blue)
                                }
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Sign In or Register")
                                        .font(.title3)
                                        .bold()
                                        .foregroundColor(.primary)
                                    
                                    Text("Sync bookings realtime")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                        .lineLimit(1)
                                }
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .font(.footnote.weight(.semibold))
                                    .foregroundColor(Color(.tertiaryLabel))
                            }
                            .padding(.vertical, 4)
                        }
                        .buttonStyle(.plain)
                    } else {
                        HStack(spacing: 16) {
                            Group {
                                if let avatarData = viewModel.userProfile.avatarData,
                                   let uiImage = UIImage(data: avatarData) {
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 64, height: 64)
                                        .clipShape(Circle())
                                } else {
                                    ZStack {
                                        Circle()
                                            .fill(Color(.systemGray6))
                                            .frame(width: 64, height: 64)
                                        Image(systemName: "person.fill")
                                            .font(.title2)
                                            .foregroundStyle(.secondary)
                                    }
                                }
                            }
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(viewModel.userProfile.name)
                                    .font(.title3)
                                    .bold()
                                
                                HStack(spacing: 4) {
                                    Image(systemName: "phone.fill")
                                    Text(viewModel.userProfile.phone.isEmpty ? "No phone added" : viewModel.userProfile.phone)
                                        .font(.system(size: 16))
                                }
                                .font(.headline)
                                .foregroundColor(Color(.systemGray2))
                            }
                            Spacer()
                        }
                        .padding(.vertical, 4)
                    }
                }
                
                Section {
                    NavigationLink {
                        SavedBarbersView()
                    } label: {
                        Label {
                            Text("Saved barbers")
                        } icon: {
                            Image(systemName: "scissors")
                                .foregroundColor(.blue)
                        }
                    }
                    
                    NavigationLink {
                        AboutProjectView()
                    } label: {
                        Label {
                            Text("About the project")
                        } icon: {
                            Image(systemName: "info.circle")
                                .foregroundColor(.blue)
                        }
                    }
                }
                
                Section {
                    NavigationLink {
                        BarberApplicationView()
                    } label: {
                        Label {
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Join as a Barber")
                                    .font(.body)
                                Text("Apply to list your shop on our partner app")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        } icon: {
                            Image(systemName: "briefcase.fill")
                                .foregroundColor(.blue)
                        }
                    }
                }
                
                if viewModel.userProfile.isRegistered {
                    Section {
                        Button(role: .destructive) {
                            viewModel.showLogoutConfirmation = true
                        } label: {
                            Label("Log out", systemImage: "rectangle.portrait.and.arrow.right")
                                .foregroundColor(.red)
                        }
                        
                        Button(role: .destructive) {
                            viewModel.showDeleteAccountConfirmation = true
                        } label: {
                            Label("Delete account", systemImage: "trash")
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
            .listStyle(.insetGrouped)
            .listSectionSpacing(.compact)
            .navigationTitle("Profile")
            .toolbar {
                if viewModel.userProfile.isRegistered {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Edit") {
                            viewModel.showEditProfile = true
                        }
                    }
                }
            }
            .sheet(isPresented: $viewModel.showEditProfile, onDismiss: {
                viewModel.loadProfile()
            }) {
                EditProfileView(currentProfile: viewModel.userProfile)
            }
            .sheet(isPresented: $viewModel.showRegisterSheet, onDismiss: {
                viewModel.loadProfile()
            }) {
                RegisterView()
            }
            .confirmationDialog(
                "Are you sure you want to log out?",
                isPresented: $viewModel.showLogoutConfirmation,
                titleVisibility: .visible
            ) {
                Button("Log Out", role: .destructive) {
                    viewModel.logout()
                }
                Button("Cancel", role: .cancel) {}
            }
            .confirmationDialog(
                "Are you sure you want to delete your account? All appointment history will be permanently lost.",
                isPresented: $viewModel.showDeleteAccountConfirmation,
                titleVisibility: .visible
            ) {
                Button("Delete Account", role: .destructive) {
                    viewModel.deleteAccount()
                }
                Button("Cancel", role: .cancel) {}
            }
        }
    }
}

#Preview {
    ProfileView()
        .environmentObject(SavedBarbersManager())
}
