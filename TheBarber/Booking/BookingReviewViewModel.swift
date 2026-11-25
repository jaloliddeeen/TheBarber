//
//  BookingReviewViewModel.swift
//  TheBarber
//
//  Created by Jaloliddin Esonboyev on 24/11/2026.
//

import SwiftUI

@MainActor
class BookingReviewViewModel: ObservableObject {
    let barber: Barber
    let selectedDate: Date
    let selectedTime: String
    
    @Published var paymentMethod: String = "Card"
    
    let paymentMethods: [String] = ["Apple Pay", "Card", "Cash"]
    let contactPhone: String = "+48 982-422-312"
    
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
    
    init(barber: Barber, selectedDate: Date, selectedTime: String) {
        self.barber = barber
        self.selectedDate = selectedDate
        self.selectedTime = selectedTime
    }
    
    var formattedDate: String {
        Self.dateFormatter.string(from: selectedDate)
    }
    
    var appointmentTimeDisplay: String {
        "\(selectedTime) | \(formattedDate)"
    }
    
    var priceRangeDisplay: String {
        "$\(barber.price) - $\(barber.price + 50)"
    }
    
    var formattedPrice: String {
        "\(barber.price)"
    }
    
    func confirmBooking(
        bookingsManager: BookingsManager,
        notificationsViewModel: NotificationsViewModel,
        onSuccess: () -> Void
    ) {
        bookingsManager.addBooking(barber: barber, date: selectedDate, time: selectedTime, paymentMethod: paymentMethod)
        
        notificationsViewModel.sendAppointmentNotification(shopName: barber.name, date: formattedDate, time: selectedTime, price: formattedPrice)
        
        onSuccess()
    }
}
