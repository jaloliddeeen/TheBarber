//
//  ProfileView.swift
//  TheBarber
//
//  Created by Jaloliddin Esonboyev on 16/08/2026.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemBackground)
                    .ignoresSafeArea()
                
                VStack {
                    VStack(spacing: 12) {
                        VStack {
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
                                    .foregroundColor(.blue)
                                }
                                
                                Spacer()
                                
                                Button(action: {
                                    //
                                }) {
                                    Image(systemName: "pencil")
                                        .font(.body.bold())
                                        .foregroundColor(.primary)
                                        .padding(10)
                                        .background(Color(.systemBackground))
                                        .clipShape(Circle())
                                        .overlay(Circle().stroke(Color(.systemGray4), lineWidth: 1))
                                }
                            }
                            .padding()
                            .background(Color(.secondarySystemBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color(.systemGray5), lineWidth: 1)
                            )
                        }
                        
                        
                        VStack(spacing: 8) {
                            NavigationLink(destination: Text("Saved Barbers")) {
                                HStack(spacing: 12) {
                                    Image(systemName: "scissors")
                                        .foregroundColor(.gray)
                                        .frame(width: 22)
                                    Text("Saved barbers")
                                        .foregroundColor(.primary)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                                .padding(.vertical, 12)
                            }
                            
                            Divider()
                            
                            NavigationLink(destination: Text("About Project View")) {
                                HStack(spacing: 12) {
                                    Image(systemName: "info.circle")
                                        .font(.title3)
                                        .foregroundColor(.gray)
                                        .frame(width: 22)
                                    Text("About the project")
                                        .foregroundColor(.primary)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                                .padding(.vertical, 12)
                            }
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal)
                        .background(Color(.secondarySystemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color(.systemGray5), lineWidth: 1)
                        )
                        
                        VStack(spacing: 8) {
                            Button(action: { }) {
                                HStack(spacing: 12) {
                                    Image(systemName: "rectangle.portrait.and.arrow.right")
                                    Text("Log out")
                                    
                                    Spacer()
                                }
                                .foregroundColor(.red)
                                .padding(.vertical, 16)
                            }
                        }
                        .padding(.horizontal)
                        .background(Color(.secondarySystemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color(.systemGray5), lineWidth: 1)
                        )
                        
                    }
                    
                    Spacer()
                    
                }
                .padding(.horizontal)
                .padding(.top, 8)
                .padding(.bottom, 16)
                .environment(\.defaultMinListHeaderHeight, 200)
                .navigationTitle("My profile")
            }
        }
    }
}

#Preview {
    ProfileView()
}
