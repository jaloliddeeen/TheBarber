//
//  NotificationsManager.swift
//  TheBarber
//
//  Created by Jaloliddin Esonboyev on 31/10/2026.
//

import SwiftUI
import UserNotifications

struct BarberNotification: Identifiable {
    let id = UUID()
    let title: String
    let shopName: String
    let date: String
    let time: String
    let price: String
    let timeAgo: String
}

class NotificationsManager: NSObject, ObservableObject, UNUserNotificationCenterDelegate {
    @Published var notifications: [BarberNotification] = []
    
    override init() {
        super.init()
        UNUserNotificationCenter.current().delegate = self
        requestPermission()
    }
    
    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if let error = error {
                print("Notification permission error: \(error.localizedDescription)")
            }
        }
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
        
        DispatchQueue.main.async {
            withAnimation(.spring(response: 0.35, dampingFraction: 0.75)) {
                self.notifications.insert(newNotification, at: 0)
            }
        }
        
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            if settings.authorizationStatus == .notDetermined {
                self.requestPermission()
            }
            
            let content = UNMutableNotificationContent()
            content.title = "Appointment Confirmed ✂️"
            content.body = "Your haircut at \(shopName) is confirmed for \(date) at \(time)."
            content.sound = UNNotificationSound.default
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1.5, repeats: false)
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("Failed to schedule notification: \(error.localizedDescription)")
                }
            }
        }
    }
    
    // display on app
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        completionHandler([.banner, .sound, .list, .badge])
    }
}
