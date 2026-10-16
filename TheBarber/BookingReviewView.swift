//
//  BookReviewView.swift
//  TheBarber
//
//  Created by Jaloliddin Esonboyev on 13/08/2026.
//

import SwiftUI

struct BookingReviewView: View {
    let barber: Barber
    let selectedDate: Date
    let selectedTime: String
    
    @Binding var selectedTab: Int
    @Binding var navPath: NavigationPath
    
    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d"
        return formatter.string(from: selectedDate)
    }
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Booking summary")) {
                    LabeledContent("Barber / Shop Name", value: barber.name)
                    LabeledContent("Price Range", value: "$\(barber.price) - $\(barber.price + 50)")
                    LabeledContent("Payment Method", value: "Cash")
                    LabeledContent("Phone Number", value: "+48 982-422-312")
                    LabeledContent("Appointment Time", value: "\(selectedTime) | \(formattedDate)")
                }
            }
            
            Button( action: {
                navPath.append(AppRoute.success)
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
    }
}

#Preview {
    NavigationStack {
        BookingReviewView(
            barber: Barber(
                name: "John Barber",
                location: "Charlie street",
                price: 120,
                rating: 4.5,
                imageName: "barber1"
            ),
            selectedDate: Date(),
            selectedTime: "12:00",
            selectedTab: .constant(0),
            navPath: .constant(NavigationPath())
        )
    }
}
