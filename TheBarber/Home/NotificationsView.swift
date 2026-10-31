//
//  NotificationsView.swift
//  TheBarber
//
//  Created by Jaloliddin Esonboyev on 16/10/2026.
//

import SwiftUI

struct NotificationsView: View {
    @Environment(\.dismiss) private var dismiss
    
    let notifications: [BarberNotification] = [
        BarberNotification(
            title: "Appointment Confirmed",
            message: "Your haircut at John Barbershop is booked for tomorrow at 14:00.",
            time: "10m ago"
        ),
        BarberNotification(
            title: "Appointment Reminder",
            message: "You have an appointment coming up in 1 hour.",
            time: "2h ago"
        ),
        BarberNotification(
            title: "Special Offer",
            message: "Get 20% off beard trims this weekend.",
            time: "1d ago"
        ),
        BarberNotification(
            title: "Review Visit",
            message: "How was your recent haircut? Tap to leave a quick rating.",
            time: "3d ago"
        )
    ]
    
    var body: some View {
        NavigationStack {
            List(notifications) { item in
                VStack(alignment: .leading, spacing: 6) {
                    HStack {
                        Text(item.title)
                            .font(.headline)
                        
                        Spacer()
                        
                        Text(item.time)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    Text(item.message)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.vertical, 4)
            }
            .navigationTitle("Notifications")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    NotificationsView()
}
