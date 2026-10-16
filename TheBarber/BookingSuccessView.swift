//
//  BookingSuccessView.swift
//  TheBarber
//
//  Created by Jaloliddin Esonboyev on 13/08/2026.
//

import SwiftUI

struct BookingSuccessView: View {
    
    @Binding var selectedTab: Int
    @Binding var navPath: NavigationPath
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 70))
                .foregroundColor(.green)
                        
            VStack(spacing: 8) {
                Text("Booking Confirmed!")
                    .font(.title2)
                    .bold()
                
                Text("You can cancel your appointment up to 2 hours before the start time.")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
            }
            
            Spacer()

            VStack(spacing: 12) {
                Button(action: {
                    navPath = NavigationPath()
                    withAnimation(.easeInOut(duration: 0.3)) {
                        selectedTab = 1
                    }
                }) {
                    Text("View Booking")
                        .font(.headline)
                        .bold()
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 52)
                        .background(Color.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                }
                
                Button(action: {
                    navPath = NavigationPath()
                    selectedTab = 0
                }) {
                    Text("Back to Home")
                        .font(.headline)
                        .bold()
                        .foregroundColor(.blue)
                        .frame(maxWidth: .infinity)
                        .frame(height: 52)
                        .background(Color.blue.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 16)
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    BookingSuccessView(selectedTab: .constant(0), navPath: .constant(NavigationPath()))
}
