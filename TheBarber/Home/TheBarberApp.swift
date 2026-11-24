//
//  TheBarberApp.swift
//  TheBarber
//
//  Created by Jaloliddin Esonboyev on 11/08/2026.
//

import SwiftUI

@main
struct TheBarberApp: App {
    @AppStorage("hasCompletedRegistration") private var hasCompletedRegistration: Bool = false
    
    @StateObject private var savedManager = SavedBarbersManager()
    @StateObject private var bookingsManager = BookingsManager()
    @StateObject private var notificationsViewModel = NotificationsViewModel()
    
    var body: some Scene {
        WindowGroup {
            Group {
                if hasCompletedRegistration {
                    MainTabView()
                        .environmentObject(savedManager)
                        .environmentObject(bookingsManager)
                        .environmentObject(notificationsViewModel)
                        .transition(.opacity)
                } else {
                    RegisterView()
                        .transition(.opacity)
                }
            }
            .animation(.easeInOut(duration: 0.35), value: hasCompletedRegistration)
        }
    }
}
