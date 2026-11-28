//
//  ProfileViewModel.swift
//  TheBarber
//
//  Created by Jaloliddin Esonboyev on 25/11/2026.
//

import SwiftUI
import Combine

@MainActor
public final class ProfileViewModel: ObservableObject {
    
    @Published public private(set) var userProfile: UserProfile = UserProfile()
    
    @Published public var showEditProfile: Bool = false
    @Published public var showRegisterSheet: Bool = false
    @Published public var showLogoutConfirmation: Bool = false
    @Published public var showDeleteAccountConfirmation: Bool = false
    
    private let keyRegistration = "hasCompletedRegistration"
    private let keyName = "userName"
    private let keyPhone = "userPhone"
    private let keyAvatar = "userAvatarData"
    
    private let userDefaults: UserDefaults
    
    public init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
        loadProfile()
    }
    
    
    public func loadProfile() {
        let isRegistered = userDefaults.bool(forKey: keyRegistration)
        let name = userDefaults.string(forKey: keyName) ?? ""
        let phone = userDefaults.string(forKey: keyPhone) ?? ""
        let avatarData = userDefaults.data(forKey: keyAvatar)
        
        self.userProfile = UserProfile(
            name: name,
            phone: phone,
            avatarData: (avatarData?.isEmpty ?? true) ? nil : avatarData,
            isRegistered: isRegistered && !name.isEmpty
        )
    }
    
    public func logout() {
        userDefaults.set(false, forKey: keyRegistration)
        userDefaults.removeObject(forKey: keyName)
        userDefaults.removeObject(forKey: keyPhone)
        userDefaults.removeObject(forKey: keyAvatar)
        
        loadProfile()
    }
    
    public func deleteAccount() {
        userDefaults.removeObject(forKey: keyRegistration)
        userDefaults.removeObject(forKey: keyName)
        userDefaults.removeObject(forKey: keyPhone)
        userDefaults.removeObject(forKey: keyAvatar)
        
        loadProfile()
    }
}
