//
//  EditProfileView.swift
//  TheBarber
//
//  Created by Jaloliddin Esonboyev on 25/11/2026.
//

import SwiftUI
import PhotosUI

struct EditProfileView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel: EditProfileViewModel
    @FocusState private var focusedField: Field?
    
    enum Field {
        case name, phone
    }
    
    init(currentProfile: UserProfile) {
        _viewModel = StateObject(wrappedValue: EditProfileViewModel(currentProfile: currentProfile))
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    HStack {
                        Spacer()
                        VStack(spacing: 8) {
                            ZStack(alignment: .bottomTrailing) {
                                if let avatarImage = viewModel.avatarImage {
                                    Image(uiImage: avatarImage)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 88, height: 88)
                                        .clipShape(Circle())
                                } else {
                                    ZStack {
                                        Circle()
                                            .fill(Color(.systemGray5))
                                            .frame(width: 88, height: 88)
                                        
                                        Image(systemName: "person.fill")
                                            .font(.system(size: 38))
                                            .foregroundColor(.secondary)
                                    }
                                }
                                
                                ZStack {
                                    Circle()
                                        .fill(Color.blue)
                                        .frame(width: 28, height: 28)
                                    
                                    Image(systemName: "camera.fill")
                                        .font(.caption2.bold())
                                        .foregroundColor(.white)
                                }
                            }
                            .overlay {
                                PhotosPicker(selection: $viewModel.selectedPhotoItem, matching: .images) {
                                    Color.clear
                                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                                        .contentShape(Circle())
                                }
                            }
                            
                            PhotosPicker(selection: $viewModel.selectedPhotoItem, matching: .images) {
                                Text("Edit Photo")
                                    .font(.subheadline)
                                    .foregroundColor(.blue)
                            }
                            .buttonStyle(.plain)
                            
                            if viewModel.avatarImage != nil || viewModel.avatarData != nil {
                                Button(role: .destructive) {
                                    withAnimation(.spring(response: 0.35, dampingFraction: 0.75)) {
                                        viewModel.removeAvatar()
                                    }
                                } label: {
                                    Text("Remove Photo")
                                        .font(.subheadline)
                                        .foregroundColor(.red)
                                }
                                .buttonStyle(.plain)
                                .padding(.top, 2)
                            }
                        }
                        Spacer()
                    }
                    .padding(.vertical, 8)
                    .listRowBackground(Color.clear)
                }
                
                Section(
                    header: Text("Personal Details"),
                    footer: Text("Name is limited to \(viewModel.maxNameLength) characters. Phone number accepts up to \(viewModel.maxPhoneLength) digits (minimum \(viewModel.minPhoneLength)).")
                ) {
                    HStack {
                        TextField("Full Name", text: $viewModel.name)
                            .focused($focusedField, equals: .name)
                            .textContentType(.name)
                        
                        Text("\(viewModel.name.count)/\(viewModel.maxNameLength)")
                            .font(.caption2)
                            .foregroundColor(viewModel.name.count >= viewModel.maxNameLength ? .red : .secondary)
                    }
                    
                    HStack {
                        TextField("Phone Number", text: $viewModel.phone)
                            .focused($focusedField, equals: .phone)
                            .keyboardType(.phonePad)
                            .textContentType(.telephoneNumber)
                        
                        Text("\(viewModel.phone.count)/\(viewModel.maxPhoneLength)")
                            .font(.caption2)
                            .foregroundColor(viewModel.phone.count >= viewModel.maxPhoneLength ? .red : .secondary)
                    }
                }
                
                if let error = viewModel.errorMessage {
                    Section {
                        Text(error)
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                }
            }
            .navigationTitle("Edit profile")
            .navigationBarTitleDisplayMode(.inline)
            .listSectionSpacing(.compact)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        withAnimation(.spring(response: 0.35, dampingFraction: 0.75)) {
                            if viewModel.saveChanges() {
                                dismiss()
                            }
                        }
                    }
                    .bold()
                    .disabled(!viewModel.isFormValid || !viewModel.hasChanges || viewModel.isProcessingImage)
                }
            }
        }
    }
}

#Preview {
    EditProfileView(currentProfile: UserProfile(name: "John Doe", phone: "+48123456789", isRegistered: true))
}
