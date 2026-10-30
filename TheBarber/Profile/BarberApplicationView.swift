//
//  BarberApplicationView.swift
//  TheBarber
//
//  Created by Jaloliddin Esonboyev on 30/10/2026.
//

import SwiftUI

struct BarberApplicationView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var fullName: String = ""
    @State private var email: String = ""
    @State private var phoneNumber: String = ""
    @State private var workPlace: String = ""
    @State private var yearsOfExperience: Int = 3
    @State private var specialization: String = "All-round Barber"
    @State private var instagramHandle: String = ""
    @State private var additionalNotes: String = ""

    @State private var showSuccessAlert: Bool = false
    
    let specializations = [
        "All-round Barber",
        "Classic Haircuts",
        "Beard Grooming",
        "Hot Towel Shave",
        "Hair Coloring"
    ]
    
    private var isFormValid: Bool {
        !fullName.trimmingCharacters(in: .whitespaces).isEmpty &&
        email.contains("@") && email.contains(".") &&
        phoneNumber.count >= 9 &&
        !workPlace.trimmingCharacters(in: .whitespaces).isEmpty
    }

 
    var body: some View {
        Form {
            Section {
                HStack(spacing: 12) {
                    Image(systemName: "clock.badge.checkmark")
                        .font(.title2)
                        .foregroundColor(.indigo)
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text("24-hour review")
                            .font(.subheadline.bold())
                        
                        Text("Submit your profile and our team will review and respond within 24 hours.")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            }
            
            Section("Personal information") {
                TextField("Full name", text: $fullName)
                    .textContentType(.name)
                TextField("Email address", text: $email)
                    .keyboardType(.emailAddress)
                    .textContentType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                
                TextField("Phone number", text: $phoneNumber)
                    .keyboardType(.phonePad)
                    .textContentType(.telephoneNumber)
            }
            
            Section("Professional background") {
                TextField("Current work", text: $workPlace)
                
                Stepper("Experience: \(yearsOfExperience) \(yearsOfExperience == 1 ? "year" : "years")", value: $yearsOfExperience, in: 0...40)
                
                Picker("Main spec.", selection: $specialization) {
                    ForEach(specializations, id: \.self) { spec in
                        Text(spec).tag(spec)
                    }
                }
            }
            
            Section(header: Text("Portfolio (optional)"), footer: Text("Providing your socials will make the process faster")) {
                TextField("@instagram handle", text: $instagramHandle)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                
                TextField("Additional notes", text: $additionalNotes)
            }
            
            Section {
                Button(action: {
                    showSuccessAlert = true
                }) {
                    Text("Submit Application")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .frame(height: 34)
                        .foregroundColor(isFormValid ? .white : .secondary)
                }
                .listRowBackground(isFormValid ? Color.blue : Color(.systemGray5))
                .disabled(!isFormValid)
            }
        }
        .navigationTitle("Barber partner application")
        .navigationBarTitleDisplayMode(.inline)
        .listSectionSpacing(.compact)
        
        .alert("Application Received!", isPresented: $showSuccessAlert) {
            Button("Done") {
                dismiss()
            }
        } message: {
            Text("Thank you, \(fullName)! We have received your application. Our onboarding team will get back to you via email or phone within 24 hours.")
        }
    }
}

#Preview {
    NavigationStack {
        BarberApplicationView()
    }
}
