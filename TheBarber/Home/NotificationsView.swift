//
//  NotificationsView.swift
//  TheBarber
//
//  Created by Jaloliddin Esonboyev on 16/10/2026.
//

import SwiftUI

struct NotificationsView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var notificationsManager: NotificationsManager
    
    var body: some View {
        NavigationStack {
            Group {
                if notificationsManager.notifications.isEmpty {
                    ContentUnavailableView(
                        "No notifications",
                        systemImage: "bell.slash",
                        description: Text("You're all caught up! Booking updates will appear here.")
                    )
                } else {
                    List(notificationsManager.notifications) { item in
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
                                    Text(item.title)
                                        .font(.subheadline)
                                        .fontWeight(.bold)
                                        .foregroundColor(.primary)
                                    
                                    Spacer()
                                    
                                    Text(item.timeAgo)
                                        .font(.caption2)
                                        .foregroundColor(.secondary)
                                }
                                
                                Text(item.shopName)
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                
                                HStack(spacing: 6) {
                                    Text("\(item.date) at \(item.time)")
                                    Text("•")
                                    Text(item.price)
                                        .fontWeight(.semibold)
                                }
                                .font(.footnote)
                                .foregroundColor(.secondary)
                                
                                // Status badge
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
        .environmentObject(NotificationsManager())
}
