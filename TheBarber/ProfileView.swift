//
//  ProfileView.swift
//  TheBarber
//
//  Created by Jaloliddin Esonboyev on 16/08/2026.
//

import SwiftUI

struct ProfileView: View {
    @State private var showEditProfile = false
    @State private var showLogoutConfirmation = false
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    HStack(spacing: 16) {
                        ZStack {
                            Circle()
                                .fill(Color(.systemGray5))
                                .frame(width: 60, height: 60)
                            
                            Image(systemName: "person")
                                .font(.title2)
                                .foregroundColor(.primary)
                        }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Taylor Swift")
                                .font(.headline)
                            
                            HStack(spacing: 4) {
                                Image(systemName: "phone")
                                    .font(.subheadline)
                                Text("+48 843-432-656")
                            }
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        }
                    }
                    .padding(.vertical, 4)
                }
                
                
                Section {
                    NavigationLink {
                        Text("Saved barbers")
                    } label: {
                        Label {
                            Text("Saved barbers")
                        } icon: {
                            Image(systemName: "scissors")
                                .foregroundColor(.blue)
                        }
                    }
                    
                    NavigationLink {
                        Text("About the project")
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
                    Button(role: .destructive) {
                        showLogoutConfirmation = true
                    } label: {
                        Label("Log out", systemImage: "rectangle.portrait.and.arrow.right")
                            .foregroundColor(.red)
                    }
                }
            }
            .listStyle(.insetGrouped)
            .listSectionSpacing(.compact)
            .navigationTitle("Profile")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Edit") {
                        showEditProfile = true
                    }
                }
            }
            .confirmationDialog(
                "Are you sure you want to log out?",
                isPresented: $showLogoutConfirmation,
                titleVisibility: .visible
            ) {
                Button("Log out", role: .destructive) {
                    //
                }
                Button("Cancel", role: .cancel) {}
            }
        }
    }
}

#Preview {
    ProfileView()
}

