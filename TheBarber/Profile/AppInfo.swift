//
//  AppInfo.swift
//  TheBarber
//
//  Created by Jaloliddin Esonboyev on 26/11/2026.
//

import SwiftUI

public struct AppFeature: Identifiable {
    public let id = UUID()
    public let title: String
    public let description: String
    public let iconName: String
    public let iconColor: Color
}

public struct LegalDocument: Identifiable, Hashable {
    public var id: String { title }
    public let title: String
    public let iconName: String
    public let content: String
}

public enum AppInfo {
    public static let appName = "TheBarber"
    public static let appTagline = "Discover top-rated barbershops, check real-time availability, and book appointments in seconds."
    public static let developerName = "Jaloliddin Esonboev"
    public static let platformName = "iOS 17+ Native (SwiftUI)"
    public static let copyright = "© 2026 TheBarber Inc. All rights reserved"
    
    /// Reads version and build number dynamically from Info.plist
    public static var appVersionString: String {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0.0"
        let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "1"
        return "Version \(version) (Build \(build))"
    }
    
    public static let features: [AppFeature] = [
        AppFeature(
            title: "Top barbers",
            description: "Handpicked professionals with verified ratings and portfolios.",
            iconName: "checkmark.seal.fill",
            iconColor: .blue
        ),
        AppFeature(
            title: "Interactive Map Discovery",
            description: "Locate nearby barbers with real-time distance calculations.",
            iconName: "map.fill",
            iconColor: .green
        ),
        AppFeature(
            title: "Instant Booking & Reminders",
            description: "Pick date and time slots without calling the salon.",
            iconName: "calendar.badge.clock",
            iconColor: .orange
        )
    ]
    
    public static let legalDocuments: [LegalDocument] = [
        LegalDocument(
            title: "Terms of Service",
            iconName: "doc.text",
            content: """
            Welcome to TheBarber. By using this application, you agree to comply with and be bound by the following terms and conditions.
            
            1. Appointment Bookings:
            All bookings created through TheBarber are held directly with the chosen barbershop. Cancellations must be made within the designated time frame.
            
            2. User Conduct:
            Users must provide accurate registration details (name and phone number) to ensure barbershops can confirm and contact you regarding appointments.
            
            3. Service Availability:
            We strive for 100% uptime, but availability of appointments is subject to individual salon schedules.
            """
        ),
        LegalDocument(
            title: "Privacy Policy",
            iconName: "hand.raised.fill",
            content: """
            Your privacy is critical to us. TheBarber respects your personal data.
            
            1. Data Collection:
            We only collect your name, phone number, and appointment details needed to process bookings.
            
            2. Location Services:
            Your location is accessed solely while using the Map feature to show nearby barbershops. Location data is never stored or tracked.
            
            3. Data Security:
            We implement industry-standard encryption to protect your sensitive information.
            """
        ),
        LegalDocument(
            title: "Open Source and Licenses",
            iconName: "scale.3d",
            content: """
            TheBarber utilizes standard Apple SF Symbols and native Apple frameworks under standard Apple Developer Program licensing.
            
            All barber imagery and portfolio assets are used for demonstration purposes.
            """
        )
    ]
}
