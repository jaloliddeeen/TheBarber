//
//  RegisterViewModel.swift
//  TheBarber
//
//  Created by Jaloliddin Esonboyev on 23/11/2026.
//

import SwiftUI

@MainActor
class RegisterViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var phoneNumber: String = ""
    
    var isFormValid: Bool {
        let trimmedName = name.trimmingCharacters(in: .whitespaces)
        let trimmedPhone = phoneNumber.trimmingCharacters(in: .whitespaces)
        return !trimmedName.isEmpty && trimmedPhone.count >= 9
    }
    
    func completeRegistration() {
        guard isFormValid else { return }
        
        let trimmedName = name.trimmingCharacters(in: .whitespaces)
        let trimmedPhone = phoneNumber.trimmingCharacters(in: .whitespaces)
        
        UserDefaults.standard.set(trimmedName, forKey: "userName")
        UserDefaults.standard.set(trimmedPhone, forKey: "userPhone")
        UserDefaults.standard.set(true, forKey: "hasCompletedRegistration")
    }
    
    func skipRegistration() {
        UserDefaults.standard.set(true, forKey: "hasCompletedRegistration")
    }
}
