//
//  BookingsViewModel.swift
//  TheBarber
//
//  Created by Jaloliddin Esonboyev on 25/11/2026.
//

import SwiftUI

@MainActor
class BookingsViewModel: ObservableObject {
    enum BookingTab: String, CaseIterable, Identifiable {
        case active = "Active"
        case inactive = "Inactive"
        
        var id: String { rawValue }
    }
    
    @Published var selectedTab: BookingTab = .active
    @Published var selectedBooking: Booking?
    
    func selectBooking(_ booking: Booking) {
        selectedBooking = booking
    }
    
    func dismissDetail() {
        selectedBooking = nil
    }
    
    func cancelBooking(_ booking: Booking, in manager: BookingsManager) {
        withAnimation(.easeInOut(duration: 0.3)) {
            manager.cancelBooking(booking)
            if selectedBooking?.id == booking.id {
                selectedBooking = nil
            }
        }
    }
}
