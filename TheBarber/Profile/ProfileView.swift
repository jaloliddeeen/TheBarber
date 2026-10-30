//
//  ProfileView.swift
//  TheBarber
//
//  Created by Jaloliddin Esonboyev on 16/08/2026.
//

import SwiftUI
import PhotosUI

struct ProfileView: View {
    @AppStorage("hasCompletedRegistration") private var hasCompletedRegistration: Bool = false
    @AppStorage("userName") private var userName: String = ""
    @AppStorage("userPhone") private var userPhone: String = ""
    @AppStorage("userAvatarData") private var userAvatarData: Data = Data()
    
    @State private var showEditProfile = false
    @State private var showRegisterSheet = false
    @State private var showLogoutConfirmation = false
    @State private var showDeleteAccountConfirmation = false
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    if userName.isEmpty {
                        Button(action: {
                            showRegisterSheet = true
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
                                if let uiImage = UIImage(data: userAvatarData) {
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
                                Text(userName)
                                    .font(.title3)
                                    .bold()
                                
                                HStack(spacing: 4) {
                                    Image(systemName: "phone.fill")
                                    Text(userPhone.isEmpty ? "No phone added" : userPhone)
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
                
                if !userName.isEmpty {
                    Section {
                        Button(role: .destructive) {
                            showLogoutConfirmation = true
                        } label: {
                            Label("Log out", systemImage: "rectangle.portrait.and.arrow.right")
                                .foregroundColor(.red)
                        }
                        
                        Button(role: .destructive) {
                            showDeleteAccountConfirmation = true
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
                if !userName.isEmpty {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Edit") {
                            showEditProfile = true
                        }
                    }
                }
            }
            
            .sheet(isPresented: $showEditProfile) {
                EditProfileView()
            }
            
            .sheet(isPresented: $showRegisterSheet) {
                RegisterView()
            }
            .confirmationDialog(
                "Are you sure you want to log out?",
                isPresented: $showLogoutConfirmation,
                titleVisibility: .visible
            ) {
                Button("Log out", role: .destructive) {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        userName = ""
                        userPhone = ""
                        userAvatarData = Data()
                        hasCompletedRegistration = false
                    }
                }
                Button("Cancel", role: .cancel) {}
            }
            
            .confirmationDialog(
                "Delete Account?",
                isPresented: $showDeleteAccountConfirmation,
                titleVisibility: .visible
            ) {
                Button("Delete Account", role: .destructive) {
                    withAnimation(.easeInOut(duration: 0.35)) {
                        userName = ""
                        userPhone = ""
                        userAvatarData = Data()
                        hasCompletedRegistration = false
                    }
                }
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("Are you sure you want to delete your account? All your profile information and local data will be permanently removed.")
            }
        }
    }
}


struct EditProfileView: View {
    @Environment(\.dismiss) private var dismiss
    
    @AppStorage("userName") private var storedName: String = ""
    @AppStorage("userPhone") private var storedPhone: String = ""
    @AppStorage("userAvatarData") private var storedAvatarData: Data = Data()
    
    private let maxNameLength = 30
    private let maxPhoneLength = 16
    
    @State private var name: String = ""
    @State private var phone: String = ""
    @State private var selectedPhotoItem: PhotosPickerItem?
    @State private var avatarImage: UIImage?
    @State private var showLogoutConfirmation = false
    
    private var isFormValid: Bool {
        let trimmedName = name.trimmingCharacters(in: .whitespaces)
        let trimmedPhone = phone.trimmingCharacters(in: .whitespaces)
        return !trimmedName.isEmpty && trimmedPhone.count >= 9
    }

    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    HStack {
                        Spacer()
                        VStack(spacing: 12) {
                            PhotosPicker(selection: $selectedPhotoItem, matching: .images) {
                                VStack(spacing: 8) {
                                    ZStack(alignment: .bottomTrailing) {
                                        if let avatarImage {
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
                                    
                                    VStack(spacing: 16) {
                                        Text("Edit Photo")
                                            .font(.subheadline)
                                            .foregroundColor(.blue)
                                        
                                        if avatarImage != nil || !storedAvatarData.isEmpty {
                                            Button(role: .destructive) {
                                                withAnimation(.spring(response: 0.35, dampingFraction: 0.75)) {
                                                    avatarImage = nil
                                                    storedAvatarData = Data()
                                                    selectedPhotoItem = nil
                                                }
                                            } label: {
                                                Text("Remove Photo")
                                                    .font(.subheadline)
                                                    .foregroundColor(.red)
                                            }
                                            .padding(.top, 2)
                                        }
                                    }
                                    .padding(.top)
                                }
                            }
                        }
                        Spacer()
                    }
                    .padding(.vertical, 8)
                    .listRowBackground(Color.clear)
                }
                
                Section(
                    header: Text("Personal Details"),
                    footer: Text("Name is limited to \(maxNameLength) characters. Phone number accepts up to \(maxPhoneLength) digits (minimum 9).")
                ) {
                    HStack {
                        TextField("Full Name", text: $name)
                            .textContentType(.name)
                        
                        Text("\(name.count)/\(maxNameLength)")
                            .font(.caption2)
                            .foregroundColor(name.count >= maxNameLength ? .red : .secondary)
                    }
                    
                    HStack {
                        TextField("Phone Number", text: $phone)
                            .keyboardType(.phonePad)
                            .textContentType(.telephoneNumber)
                        
                        Text("\(phone.count)/\(maxPhoneLength)")
                            .font(.caption2)
                            .foregroundColor(phone.count >= maxPhoneLength ? .red : .secondary)
                    }
                }
            }
            .navigationTitle("Edit profile")
            .navigationBarTitleDisplayMode(.inline)
            .listSectionSpacing(.compact)
            
            .onChange(of: name) { _, newValue in
                if newValue.count > maxNameLength {
                    name = String(newValue.prefix(maxNameLength))
                }
            }
            .onChange(of: phone) { _, newValue in
                if newValue.count > maxPhoneLength {
                    phone = String(newValue.prefix(maxPhoneLength))
                }
            }
            
            .onAppear {
                name = storedName
                phone = storedPhone
                if let uiImage = UIImage(data: storedAvatarData) {
                    avatarImage = uiImage
                }
            }
            .onChange(of: selectedPhotoItem) { _, newItem in
                Task {
                    if let data = try? await newItem?.loadTransferable(type: Data.self),
                       let uiImage = UIImage(data: data) {
                        withAnimation(.spring(response: 0.35, dampingFraction: 0.75)) {
                            avatarImage = uiImage
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        withAnimation(.spring(response: 0.35, dampingFraction: 0.75)) {
                            storedName = name.trimmingCharacters(in: .whitespaces)
                            storedPhone = phone.trimmingCharacters(in: .whitespaces)
                            if let avatarImage, let jpegData = avatarImage.jpegData(compressionQuality: 0.8) {
                                storedAvatarData = jpegData
                            } else if avatarImage == nil {
                                storedAvatarData = Data()
                            }
                        }
                        dismiss()
                    }
                    .bold()
                    .disabled(name.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
        }
    }
}

#Preview {
    ProfileView()
        .environmentObject(SavedBarbersManager())
}

