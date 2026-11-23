//
//  RegisterView.swift
//  TheBarber
//
//  Created by Jaloliddin Esonboyev on 11/08/2026.
//

import SwiftUI

struct RegisterView: View {
    @Environment(\.dismiss) private var dismiss
    
    @StateObject private var viewModel = RegisterViewModel()
    @FocusState private var focusedField: Field?
    
    enum Field {
        case name
        case phone
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
                    
                    TextField("First Name", text: $viewModel.name)
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
                    
                    TextField("Phone Number", text: $viewModel.phoneNumber)
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
                        viewModel.completeRegistration()
                    }
                    dismiss()
                }) {
                    Text("Continue")
                        .font(.headline)
                        .bold()
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 52)
                        .background(viewModel.isFormValid ? Color.blue : Color.blue.opacity(0.4))
                        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                }
                .disabled(!viewModel.isFormValid)
                
                Button(action: {
                    withAnimation(.spring(response: 0.35, dampingFraction: 0.75)) {
                        viewModel.skipRegistration()
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
