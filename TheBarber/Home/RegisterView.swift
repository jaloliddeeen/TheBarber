//
//  RegisterView.swift
//  TheBarber
//
//  Created by Jaloliddin Esonboyev on 11/08/2026.
//

import SwiftUI

struct RegisterView: View {
    @Environment(\.dismiss) private var dismiss
    
    @AppStorage("hasCompletedRegistration") private var hasCompletedRegistration: Bool = false
    @AppStorage("userName") private var storedName: String = ""
    @AppStorage("userPhone") private var storedPhone: String = ""
    
    @State private var name: String = ""
    @State private var phoneNumber: String = ""
    @FocusState private var focusedField: Field?
    
    enum Field {
        case name
        case phone
    }
    
    private var isFormValid: Bool {
        !name.trimmingCharacters(in: .whitespaces).isEmpty && phoneNumber.count >= 9
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 28) {
            
            VStack(alignment: .leading, spacing: 8) {
                Image(systemName: "scissors.badge.ellipsis")
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(.blue)
                    .padding(.bottom, 8)
                
                Text("Create Account")
                    .font(.largeTitle)
                    .bold()
                
                Text("Enter your details to get started with booking appointments.")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding(.top, 16)
            
            VStack(spacing: 16) {
                HStack(spacing: 12) {
                    Image(systemName: "person.fill")
                        .foregroundColor(.secondary)
                    
                    TextField("First Name", text: $name)
                        .textContentType(.givenName)
                        .focused($focusedField, equals: .name)
                        .submitLabel(.next)
                        .onSubmit {
                            focusedField = .phone
                        }
                }
                .padding()
                .background(Color(.secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                
                HStack(spacing: 12) {
                    Image(systemName: "phone.fill")
                        .foregroundColor(.secondary)
                    
                    TextField("Phone Number", text: $phoneNumber)
                        .keyboardType(.phonePad)
                        .textContentType(.telephoneNumber)
                        .focused($focusedField, equals: .phone)
                }
                .padding()
                .background(Color(.secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
            }
            
            Spacer()
            
            VStack(spacing: 8) {
                Button(action: {
                    withAnimation(.spring(response: 0.35, dampingFraction: 0.75)) {
                        storedName = name.trimmingCharacters(in: .whitespaces)
                        storedPhone = phoneNumber.trimmingCharacters(in: .whitespaces)
                        hasCompletedRegistration = true
                    }
                    dismiss()
                }) {
                    Text("Continue")
                        .font(.headline)
                        .bold()
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 52)
                        .background(isFormValid ? Color.blue : Color.blue.opacity(0.4))
                        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                }
                .disabled(!isFormValid)
                
                Button(action: {
                    withAnimation(.spring(response: 0.35, dampingFraction: 0.75)) {
                        hasCompletedRegistration = true
                    }
                    dismiss()
                }) {
                    Text("Skip")
                        .font(.headline)
                        .bold()
                        .foregroundColor(.primary)
                        .frame(maxWidth: .infinity)
                        .frame(height: 52)
                        .background(Color(.systemGray6))
                        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                }
            }
            .padding(.bottom, 8)
        }
        .padding(.horizontal, 24)
        .background(
            Color.clear
                .contentShape(Rectangle())
                .onTapGesture {
                    focusedField = nil
                }
        )
    }
}

#Preview {
    RegisterView()
}
