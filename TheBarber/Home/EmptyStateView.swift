//
//  EmptyStateView.swift
//  TheBarber
//
//  Created by Jaloliddin Esonboyev on 27/11/2026.
//

import SwiftUI

public struct EmptyStateView: View {
    public let title: String
    public let systemImage: String
    public let description: String
    public var actionTitle: String? = nil
    public var action: (() -> Void)? = nil
    public var topPadding: CGFloat = 40
    
    public init(
        title: String,
        systemImage: String,
        description: String,
        actionTitle: String? = nil,
        topPadding: CGFloat = 40,
        action: (() -> Void)? = nil
    ) {
        self.title = title
        self.systemImage = systemImage
        self.description = description
        self.actionTitle = actionTitle
        self.topPadding = topPadding
        self.action = action
    }
    
    public var body: some View {
        ContentUnavailableView {
            Label(title, systemImage: systemImage)
        } description: {
            Text(description)
        } actions: {
            if let actionTitle, let action {
                Button(actionTitle, action: action)
                    .buttonStyle(.borderedProminent)
            }
        }
        .padding(.top, topPadding)
    }
}

extension EmptyStateView {
    
    public static func noFilterResults(onReset: @escaping () -> Void) -> EmptyStateView {
        EmptyStateView(
            title: "No Barbers Found",
            systemImage: "line.3.horizontal.decrease.circle",
            description: "Try adjusting your price or rating filters.",
            actionTitle: "Reset Filters",
            topPadding: 40,
            action: onReset
        )
    }
    
    public static func noSavedBarbers(onExplore: (() -> Void)? = nil) -> EmptyStateView {
        EmptyStateView(
            title: "No Saved Barbers",
            systemImage: "heart.slash",
            description: "Barbers you bookmark will appear here.",
            actionTitle: onExplore != nil ? "Explore Barbers" : nil,
            topPadding: 40,
            action: onExplore
        )
    }
    
    public static var noActiveBookings: EmptyStateView {
        EmptyStateView(
            title: "No bookings yet",
            systemImage: "calendar.badge.plus",
            description: "Bookings will appear here",
            topPadding: 120
        )
    }
    
    public static var noInactiveBookings: EmptyStateView {
        EmptyStateView(
            title: "No inactive bookings",
            systemImage: "calendar.badge.clock",
            description: "Past bookings will appear here",
            topPadding: 120
        )
    }
    
    public static var noNotifications: EmptyStateView {
        EmptyStateView(
            title: "No notifications",
            systemImage: "bell.slash",
            description: "You're all caught up! Booking updates will appear here.",
            topPadding: 40
        )
    }
}

#Preview {
    ScrollView {
        VStack(spacing: 30) {
            EmptyStateView.noActiveBookings
            Divider()
            EmptyStateView.noInactiveBookings
        }
    }
}
