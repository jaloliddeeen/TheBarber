//
//  NotificationsView.swift
//  TheBarber
//
//  Created by Jaloliddin Esonboyev on 16/10/2026.
//

import SwiftUI

struct NotificationsView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var viewModel: NotificationsViewModel
    
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isEmpty {
                    ContentUnavailableView(
                        "No notifications",
                        systemImage: "bell.slash",
                        description: Text("You're all caught up! Booking updates will appear here.")
                    )
                } else {
                    List {
                        ForEach(viewModel.notifications) { item in
                            NotificationRowView(notification: item)
                        }
                        .onDelete { indexSet in
                            viewModel.deleteNotification(at: indexSet)
                        }
                    }
                }
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

struct NotificationRowView: View {
    let notification: BarberNotification
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(Color.blue.opacity(0.12))
                    .frame(width: 44, height: 44)
                
                Image(systemName: "calendar.badge.checkmark")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.blue)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(notification.title)
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    
                    Spacer()
                    
                    Text(notification.timeAgo)
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
                
                Text(notification.shopName)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                HStack(spacing: 6) {
                    Text("\(notification.date) at \(notification.time)")
                    Text("•")
                    Text(notification.price)
                        .fontWeight(.semibold)
                }
                .font(.footnote)
                .foregroundColor(.secondary)
                
                Text("Confirmed")
                    .font(.caption2)
                    .fontWeight(.bold)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 3)
                    .background(Color.green.opacity(0.12))
                    .foregroundColor(.green)
                    .clipShape(Capsule())
                    .padding(.top, 2)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    NotificationsView()
        .environmentObject(NotificationsViewModel())
}
