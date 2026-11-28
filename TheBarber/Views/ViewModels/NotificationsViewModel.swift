//
//  NotificationsViewModel.swift
//  TheBarber
//
//  Created by Jaloliddin Esonboyev on 23/11/2026.
//

import SwiftUI

struct BarberNotification: Identifiable {
    let id = UUID()
    let title: String
    let shopName: String
    let date: String
    let time: String
    let price: String
    let timeAgo: String
}

@MainActor
class NotificationsViewModel: ObservableObject {
    @Published var notifications: [BarberNotification] = []
    
    private let notificationService: LocalNotificationService
    
    init(notificationService: LocalNotificationService = .shared) {
        self.notificationService = notificationService
    }
    
    var isEmpty: Bool {
        notifications.isEmpty
    }
    
    func sendAppointmentNotification(shopName: String, date: String, time: String, price: String) {
        let newNotification = BarberNotification(
            title: "Appointment Confirmed",
            shopName: shopName,
            date: date,
            time: time,
            price: price,
            timeAgo: "Just now"
        )
        
        withAnimation(.spring(response: 0.35, dampingFraction: 0.75)) {
            notifications.insert(newNotification, at: 0)
        }
        
        notificationService.scheduleBanner(
            title: "Appointment Confirmed ✂️",
            body: "Your haircut at \(shopName) is confirmed for \(date) at \(time)."
        )
    }
    
    func deleteNotification(at offsets: IndexSet) {
        notifications.remove(atOffsets: offsets)
    }
    
    func clearAll() {
        withAnimation {
            notifications.removeAll()
        }
    }
}
