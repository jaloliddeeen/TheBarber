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
                PrimaryButton(title: "View booking") {
                    selectedTab = 1
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        navPath = NavigationPath()
                    }
                }
                
                SecondaryButton(title: "Back to home") {
                    navPath = NavigationPath()
                    selectedTab = 0
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
