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
    
    var body: some Scene {
        WindowGroup {
            if hasCompletedRegistration {
                MainTabView()
            } else {
                RegisterView()
            }
        }
    }
}
