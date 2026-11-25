//
//  UserProfile.swift
//  TheBarber
//
//  Created by Jaloliddin Esonboyev on 25/11/2026.
//

import Foundation

public struct UserProfile: Equatable {
    public var name: String
    public var phone: String
    public var avatarData: Data?
    public var isRegistered: Bool
    
    public init(
        name: String = "",
        phone: String = "",
        avatarData: Data? = nil,
        isRegistered: Bool = false
    ) {
        self.name = name
        self.phone = phone
        self.avatarData = avatarData
        self.isRegistered = isRegistered
    }
    
    public var initials: String {
        let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return "?" }
        
        let components = trimmed.components(separatedBy: " ").filter { !$0.isEmpty }
        if components.count >= 2,
           let first = components[0].first,
           let second = components[1].first {
            return "\(first)\(second)".uppercased()
        } else if let single = components.first?.prefix(2) {
            return String(single).uppercased()
        }
        return "?"
    }
}
