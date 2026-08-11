//
//  BookReviewView.swift
//  TheBarber
//
//  Created by Jaloliddin Esonboyev on 13/08/2026.
//

import SwiftUI

struct BookReviewView: View {
    let barber: Barber
    let selectedDate: Date
    let selectedTime: String
    
    @State private var navigateToSuccess = false
    
    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d-MMMM"
        return formatter.string(from: selectedDate)
    }
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Booking summary")) {
                    LabeledContent("Barber / Shop Name", value: barber.name)
                    LabeledContent("Price Range", value: "$\(barber.price) - $\(barber.price + 50)")
                    LabeledContent("Payment Method", value: "Cash")
                    LabeledContent("Phone Number", value: "+998 94 633-24-24")
                    LabeledContent("Appointment Time", value: "\(selectedTime) | \(formattedDate)")
                }
            }
            
            Button( action: {
                navigateToSuccess = true
            }) {
                Text("Confirm booking")
                    .font(.headline)
                    .bold()
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 52)
                    .background(Color.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 16)
        }
        .navigationTitle("Confirm booking")
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(isPresented: $navigateToSuccess) {
            BookingSuccessView()
        }
    }
}

#Preview {
    BookReviewView()
}
