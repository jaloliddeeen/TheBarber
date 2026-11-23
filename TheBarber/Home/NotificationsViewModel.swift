//
//  NotificationsViewModel.swift
//  TheBarber
//
//  Created by Jaloliddin Esonboyev on 23/11/2026.
//

import SwiftUI

struct BarberNotification: Identifiable {
    let id = UUID()
    let title: String
    let shopName: String
    let date: String
    let time: String
    let price: String
    let timeAgo: String
}
