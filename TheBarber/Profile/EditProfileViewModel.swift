//
//  EditProfileViewModel.swift
//  TheBarber
//
//  Created by Jaloliddin Esonboyev on 25/11/2026.
//

import SwiftUI
import PhotosUI
import Combine

@MainActor
public final class EditProfileViewModel: ObservableObject {
    
    public let maxNameLength: Int = 30
    public let maxPhoneLength: Int = 16
    public let minPhoneLength: Int = 9
    
    private let keyRegistration = "hasCompletedRegistration"
    private let keyName = "userName"
    private let keyPhone = "userPhone"
    private let keyAvatar = "userAvatarData"
    
    private let userDefaults: UserDefaults
    private let initialProfile: UserProfile
    
    @Published public var name: String = "" {
        didSet {
            if name.count > maxNameLength {
                name = String(name.prefix(maxNameLength))
            }
        }
    }
    
    @Published public var phone: String = "" {
        didSet {
            if phone.count > maxPhoneLength {
                phone = String(phone.prefix(maxPhoneLength))
            }
        }
    }
    
    @Published public var selectedPhotoItem: PhotosPickerItem? = nil {
        didSet {
            if let selectedPhotoItem {
                Task {
                    await loadAvatar(from: selectedPhotoItem)
                }
            }
        }
    }
    
    @Published public private(set) var avatarImage: UIImage? = nil
    @Published public private(set) var avatarData: Data? = nil
    @Published public private(set) var isProcessingImage: Bool = false
    @Published public var errorMessage: String? = nil
    
    public var isFormValid: Bool {
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedPhone = phone.trimmingCharacters(in: .whitespacesAndNewlines)
        return !trimmedName.isEmpty && (trimmedPhone.isEmpty || trimmedPhone.count >= minPhoneLength)
    }
    
    public var hasChanges: Bool {
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedPhone = phone.trimmingCharacters(in: .whitespacesAndNewlines)
        
        return trimmedName != initialProfile.name ||
               trimmedPhone != initialProfile.phone ||
               avatarData != initialProfile.avatarData
    }
    
    public init(currentProfile: UserProfile, userDefaults: UserDefaults = .standard) {
        self.initialProfile = currentProfile
        self.userDefaults = userDefaults
        
        self.name = currentProfile.name
        self.phone = currentProfile.phone
        self.avatarData = currentProfile.avatarData
        
        if let data = currentProfile.avatarData, let uiImage = UIImage(data: data) {
            self.avatarImage = uiImage
        }
    }
    
    public func loadAvatar(from item: PhotosPickerItem) async {
        isProcessingImage = true
        errorMessage = nil
        
        do {
            if let data = try await item.loadTransferable(type: Data.self),
               let uiImage = UIImage(data: data) {
                let compressedData = uiImage.jpegData(compressionQuality: 0.8)
                withAnimation(.spring(response: 0.35, dampingFraction: 0.75)) {
                    self.avatarImage = uiImage
                    self.avatarData = compressedData
                }
            } else {
                self.errorMessage = "Could not load the selected image."
            }
        } catch {
            self.errorMessage = "Failed to process photo: \(error.localizedDescription)"
        }
        
        isProcessingImage = false
    }
    
    public func removeAvatar() {
        self.avatarImage = nil
        self.avatarData = nil
        self.selectedPhotoItem = nil
    }
    
    public func saveChanges() -> Bool {
        guard isFormValid else { return false }
        
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedPhone = phone.trimmingCharacters(in: .whitespacesAndNewlines)
        
        userDefaults.set(trimmedName, forKey: keyName)
        userDefaults.set(trimmedPhone, forKey: keyPhone)
        userDefaults.set(true, forKey: keyRegistration)
        
        if let avatarData, !avatarData.isEmpty {
            userDefaults.set(avatarData, forKey: keyAvatar)
        } else {
            userDefaults.removeObject(forKey: keyAvatar)
        }
        
        return true
    }
}
