//
//  BarberApplicationVModel.swift
//  TheBarber
//
//  Created by Jaloliddin Esonboyev on 25/11/2026.
//

import SwiftUI
import Combine

@MainActor
public final class BarberApplicationVModel: ObservableObject {
    
    @Published public var fullName: String = ""
    @Published public var email: String = ""
    @Published public var phoneNumber: String = ""
    @Published public var workPlace: String = ""
    @Published public var yearsOfExperience: Int = 3
    @Published public var selectedSpecialization: BarberSpecialization = .allRound
    @Published public var instagramHandle: String = ""
    @Published public var additionalNotes: String = ""
    
    @Published public var showSuccessAlert: Bool = false
    @Published public private(set) var isSubmitting: Bool = false
    
    public let availableSpecializations = BarberSpecialization.allCases
    
    public var isFormValid: Bool {
        let trimmedName = fullName.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedWork = workPlace.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedPhone = phoneNumber.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let isValidEmail = trimmedEmail.contains("@") && trimmedEmail.contains(".") && trimmedEmail.count >= 5
        let isValidPhone = trimmedPhone.count >= 9
        
        return !trimmedName.isEmpty && isValidEmail && isValidPhone && !trimmedWork.isEmpty
    }
    
    public var experienceLabel: String {
        "Experience: \(yearsOfExperience) \(yearsOfExperience == 1 ? "year" : "years")"
    }
    
    public var successAlertMessage: String {
        let name = fullName.trimmingCharacters(in: .whitespacesAndNewlines)
        let displayName = name.isEmpty ? "Partner" : name
        return "Thank you, \(displayName)! We have received your application. Our onboarding team will get back to you via email or phone within 24 hours."
    }
    
    public func submitApplication() {
        guard isFormValid else { return }
        
        isSubmitting = true
        
        let sanitizedInstagram: String? = {
            let clean = instagramHandle.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "@", with: "")
            return clean.isEmpty ? nil : clean
        }()
        
        let sanitizedNotes: String? = {
            let clean = additionalNotes.trimmingCharacters(in: .whitespacesAndNewlines)
            return clean.isEmpty ? nil : clean
        }()
        
        _ = BarberApplication(
            fullName: fullName.trimmingCharacters(in: .whitespacesAndNewlines),
            email: email.trimmingCharacters(in: .whitespacesAndNewlines).lowercased(),
            phoneNumber: phoneNumber.trimmingCharacters(in: .whitespacesAndNewlines),
            workPlace: workPlace.trimmingCharacters(in: .whitespacesAndNewlines),
            yearsOfExperience: yearsOfExperience,
            specialization: selectedSpecialization,
            instagramHandle: sanitizedInstagram,
            additionalNotes: sanitizedNotes
        )
        
        isSubmitting = false
        showSuccessAlert = true
    }
}
