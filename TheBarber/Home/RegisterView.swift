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
        case name, phone
    }
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 28) {
            
            RegisterHeaderView()
            
            VStack(spacing: 16) {
                CustomInputField(icon: "person.fill") {
                    TextField("First Name", text: $viewModel.name)
                        .textContentType(.givenName)
                        .focused($focusedField, equals: .name)
                        .submitLabel(.next)
                        .onSubmit {
                            focusedField = .phone
                        }
                }
                
                CustomInputField(icon: "phone.fill") {
                    TextField("Phone Number", text: $viewModel.phoneNumber)
                        .keyboardType(.phonePad)
                        .textContentType(.telephoneNumber)
                        .focused($focusedField, equals: .phone)
                }
            }
            
            Spacer()
            
            VStack(spacing: 8) {
                PrimaryButton(
                    title: "Continue",
                    isEnabled: viewModel.isFormValid
                ) {
                    withAnimation(.spring(response: 0.35, dampingFraction: 0.75)) {
                        viewModel.completeRegistration()
                    }
                    dismiss()
                }
                
                SecondaryButton(title: "Skip") {
                    withAnimation(.spring(response: 0.35, dampingFraction: 0.75)) {
                        viewModel.skipRegistration()
                    }
                    dismiss()
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

private struct RegisterHeaderView: View {
    var body: some View {
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
    }
}


struct CustomInputField<Content: View>: View {
    let icon: String
    @ViewBuilder let content: () -> Content
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(.secondary)
            
            content()
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
    }
}


#Preview {
    RegisterView()
}
