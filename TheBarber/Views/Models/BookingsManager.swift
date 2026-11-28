//
//  BookingsManager.swift
//  TheBarber
//
//  Created by Jaloliddin Esonboyev on 29/10/2026.
//

import SwiftUI

class BookingsManager: ObservableObject {
    @Published var activeBookings: [Booking] = []
    
    func addBooking(barber: Barber, date: Date, time: String, paymentMethod: String) {
        let monthFormatter = DateFormatter()
        monthFormatter.dateFormat = "MMM"
        let month = monthFormatter.string(from: date).uppercased()
        
        let dayFormatter = DateFormatter()
        dayFormatter.dateFormat = "d"
        let day = dayFormatter.string(from: date)
        
        let newBooking = Booking(
            month: month,
            day: day,
            time: time,
            barber: barber,
            price: "$\(barber.price)",
            status: "Confirmed",
            paymentMethod: paymentMethod,
            phoneNumber: "+48 834-334-654"
        )
        
        activeBookings.insert(newBooking, at: 0)
    }
    
    func cancelBooking(_ booking: Booking) {
        withAnimation(.easeInOut) {
            activeBookings.removeAll { $0.id == booking.id }
        }
    }
}
