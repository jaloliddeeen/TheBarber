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
    
    @EnvironmentObject var bookingsManager: BookingsManager
    @State private var paymentMethod = "Apple pay"
    let paymentMethods = ["Card", "Cash"]
    
    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: selectedDate)
    }
    
    var body: some View {
        VStack {
            Form {
                Section {
                    LabeledContent("Barber / Shop Name", value: barber.name)
                    LabeledContent("Price Range", value: "$\(barber.price) - $\(barber.price + 50)")
                    LabeledContent("Phone Number", value: "+48 982-422-312")
                    LabeledContent("Appointment Time", value: "\(selectedTime) | \(formattedDate)")
                }
                
                Section {
                    Picker("Payment method", selection: $paymentMethod) {
                        ForEach(paymentMethods, id: \.self) { method in
                            Text(method).tag(method)
                        }
                    }
                }
            }
            .listSectionSpacing(.compact)
            
            
            Button( action: {
                bookingsManager.addBooking(
                    barber: barber,
                    date: selectedDate,
                    time: selectedTime,
                    paymentMethod: paymentMethod
                )
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
