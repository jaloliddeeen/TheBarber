//
//  BarberApplicationView.swift
//  TheBarber
//
//  Created by Jaloliddin Esonboyev on 30/10/2026.
//

import SwiftUI

struct BarberApplicationView: View {
    @Environment(\.dismiss) private var dismiss
    
    @StateObject private var viewModel = BarberApplicationVModel()

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
                TextField("Full name", text: $viewModel.fullName)
                    .textContentType(.name)
                TextField("Email address", text: $viewModel.email)
                    .keyboardType(.emailAddress)
                    .textContentType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                
                TextField("Phone number", text: $viewModel.phoneNumber)
                    .keyboardType(.phonePad)
                    .textContentType(.telephoneNumber)
            }
            
            Section("Professional background") {
                TextField("Current work", text: $viewModel.workPlace)
                
                Stepper(viewModel.experienceLabel, value: $viewModel.yearsOfExperience, in: 0...40)
                
                Picker("Main spec.", selection: $viewModel.selectedSpecialization) {
                    ForEach(viewModel.availableSpecializations) { spec in
                        Text(spec.rawValue).tag(spec)
                    }
                }
            }
            
            Section(
                header: Text("Portfolio (optional)"),
                footer: Text("Providing your socials will make the process faster")
            ) {
                TextField("@instagram handle", text: $viewModel.instagramHandle)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                
                TextField("Additional notes", text: $viewModel.additionalNotes)
            }
            
            Section {
                Button(action: {
                    viewModel.submitApplication()
                }) {
                    HStack {
                        Spacer()
                        if viewModel.isSubmitting {
                            ProgressView()
                                .tint(.white)
                        } else {
                            Text("Submit application")
                                .font(.headline)
                        }
                        Spacer()
                    }
                    .frame(height: 30)
                    .foregroundColor(viewModel.isFormValid ? .white : .secondary)
                }
                .listRowBackground(viewModel.isFormValid ? Color.blue : Color(.systemGray5))
                .disabled(!viewModel.isFormValid || viewModel.isSubmitting)
            }
        }
        .navigationTitle("Barber partner application")
        .navigationBarTitleDisplayMode(.inline)
        .listSectionSpacing(.compact)
        .contentMargins(.top, 4, for: .scrollContent)
        
        .alert("Application Received!", isPresented: $viewModel.showSuccessAlert) {
            Button("Done") {
                dismiss()
            }
        } message: {
            Text(viewModel.successAlertMessage)
        }
    }
}

#Preview {
    NavigationStack {
        BarberApplicationView()
    }
}
