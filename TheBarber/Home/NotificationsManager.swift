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
    let message: String
    let time: String
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
    
    func sendAppointmentNotification(shopName: String, date: String, time: String) {
        let newNotification = BarberNotification(
            title: "Appointment confirmed",
            message: "Your haircut at \(shopName) is booked for \(date) at \(time).",
            time: "Just now")
        
        DispatchQueue.main.async {
            withAnimation(.spring(response: 0.35, dampingFraction: 0.75)) {
                self.notifications.insert(newNotification, at: 0)
            }
        }
        
        // trigger with sound
        let content = UNMutableNotificationContent()
        content.title = "Appointment confirmed"
        content.body = "Your haircut at \(shopName) is confirmed for \(date) at \(time)."
        content.sound = .default
        
        //trigger after 1 sec
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Failed to schedule: \(error.localizedDescription)")
            }
        }
        
        // display on app
        func userNotificationCenter(
            _ center: UNUserNotificationCenter,
            willPresent notification: UNNotification,
            withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
        ) {
            completionHandler([.banner, .sound, .badge])
        }
    }
}
