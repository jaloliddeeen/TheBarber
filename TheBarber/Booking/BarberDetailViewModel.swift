//
//  BarberDetailViewModel.swift
//  TheBarber
//
//  Created by Jaloliddin Esonboyev on 24/11/2026.
//

import SwiftUI

@MainActor
class BarberDetailViewModel: ObservableObject {
    let barber: Barber
    
    @Published var selectedDate: Date = Date()
    @Published var selectedTime: String = "12:00"
    
    let timeSlots: [String] = [
        "11:15", "12:00", "12:45", "13:30", "14:15", "15:00"
    ]
    
    let portfolioImages: [String] = [
        "portfolio2", "portfolio3", "portfolio4", "portfolio5"
    ]
    
    let contactPhone: String = "+998 93 243-64-11"
    
    init(barber: Barber) {
        self.barber = barber
    }
    
    var priceRange: String {
        "$\(barber.price) - $\(barber.price + 50)"
    }
    
    var shareItemText: String {
        "\(barber.name), located at \(barber.location). Book on TheBarber!"
    }
    
    var shareMessageText: String {
        "Check out \(barber.name) on TheBarber"
    }
    
    func selectTime(_ time: String) {
        selectedTime = time
    }
    
    func makeReviewRoute() -> AppRoute {
        .review(barber, selectedDate, selectedTime)
    }
    
    func isSaved(in savedManager: SavedBarbersManager) -> Bool {
        savedManager.isSaved(barber)
    }
    
    func toggleSave(in savedManager: SavedBarbersManager) {
        withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
            savedManager.toggleSave(barber)
        }
    }
}
