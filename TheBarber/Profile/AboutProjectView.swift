//
//  AboutProjectView.swift
//  TheBarber
//
//  Created by Jaloliddin Esonboyev on 29/10/2026.
//

import SwiftUI

struct AboutProjectView: View {
    @State private var showingPrivacy = false
    @State private var showingTerms = false
    
    var body: some View {
        List {
            Section {
                VStack(spacing: 16) {
                    Image("AppIcon1")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                    
                    VStack(spacing: 4) {
                        Text("TheBarber")
                            .font(.title2)
                            .bold()
                        
                        Text("Version 1.0.0 (Build 2026.1)")
                            .font(.body)
                        
                        Text("Discover top-rated barbershops, check real-time availability, and book appointments in seconds.")
                            .font(.body)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.secondary)
                            .padding(.horizontal, 8)
                            .padding(.bottom, 6)
                    }
                }
                .frame(maxWidth: .infinity)
                .listRowBackground(Color.clear)
            }
            
            Section("Features") {
                Label {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Top barbers")
                            .font(.headline)
                            .bold()
                        Text("Handpicked professionals with verified ratings and portfolios.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                } icon: {
                    Image(systemName: "checkmark.seal.fill")
                        .foregroundColor(.blue)
                }
                
                Label {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Interactive Map Discovery")
                            .font(.headline)
                            .bold()
                        Text("Locate nearby barbers with real-time distance calculations.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                } icon: {
                    Image(systemName: "map.fill")
                        .foregroundColor(.green)
                }
                
                Label {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Instant Booking & Reminders")
                            .font(.headline)
                            .bold()
                        Text("Pick date and time slots without calling the salon.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                } icon: {
                    Image(systemName: "calendar.badge.clock")
                        .foregroundColor(.orange)
                }
            }
            
            Section("Project information") {
                HStack {
                    Label("Platform", systemImage: "apple.logo")
                        .foregroundStyle(.primary)
                    Spacer()
                    Text("iOS 17+ Native (SwiftUI)")
                        .foregroundStyle(.secondary)
                        .font(.subheadline)
                }
                
                HStack {
                    Label("Created by", systemImage: "person.crop.circle")
                        .foregroundStyle(.primary)
                    Spacer()
                    Text("Jaloliddin Esonboev")
                        .foregroundStyle(.secondary)
                        .font(.subheadline)
                }
            }
            
            Section("Legal") {
                NavigationLink {
                    LegalDocumentView(
                        title: "Terms of Service",
                        content: """
                        Welcome to TheBarber. By using this application, you agree to comply with and be bound by the following terms and conditions.
                        
                        1. Appointment Bookings:
                        All bookings created through TheBarber are held directly with the chosen barbershop. Cancellations must be made within the designated time frame.
                        
                        2. User Conduct:
                        Users must provide accurate registration details (name and phone number) to ensure barbershops can confirm and contact you regarding appointments.
                        
                        3. Service Availability:
                        We strive for 100% uptime, but availability of appointments is subject to individual salon schedules.
                        """
                    )
                } label: {
                    Label("Terms of service", systemImage: "doc.text")
                }
                
                NavigationLink {
                    LegalDocumentView(
                        title: "Privacy Policy",
                        content: """
                        Your privacy is critical to us. TheBarber respects your personal data.
                        
                        1. Data Collection:
                        We only collect your name, phone number, and appointment details needed to process bookings.
                        
                        2. Location Services:
                        Your location is accessed solely while using the Map feature to show nearby barbershops. Location data is never stored or tracked.
                        
                        3. Data Security:
                        We implement industry-standard encryption to protect your sensitive information.
                        """
                    )
                } label: {
                    Label("Privacy Policy", systemImage: "hand.raised.fill")
                }
                
                NavigationLink {
                    LegalDocumentView(
                        title: "Licences",
                        content: """
                        TheBarber utilizes standard Apple SF Symbols and native Apple frameworks under their standard Apple Developer Program licensing.
                        
                        All barber imagery and portfolio assets are used for demonstration purposes.
                        """
                    )
                } label: {
                    Label("Open Source and Licenses", systemImage: "scale.3d")
                }
            }
            
            Section {
                VStack(alignment: .center, spacing: 4) {
                    Text("© 2026 TheBarber Inc.")
                    Text("All rights reserved")
                }
                .font(.caption)
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity)
                .listRowBackground(Color.clear)
            }
        }
        .listStyle(.insetGrouped)
        .navigationTitle("About")
        .navigationBarTitleDisplayMode(.inline)
    }
}


struct LegalDocumentView: View {
    let title: String
    let content: String
    
    var body: some View {
        ScrollView {
            Text(content)
                .font(.body)
                .foregroundColor(.secondary)
                .lineSpacing(6)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(.systemGroupedBackground))
    }
}

#Preview {
    NavigationStack {
        AboutProjectView()
    }
}
