//
//  Booking.swift
//  TheBarber
//
//  Created by Jaloliddin Esonboyev on 25/11/2026.
//

import Foundation

struct Booking: Identifiable, Hashable {
    let id = UUID()
    let month: String
    let day: String
    let time: String
    let barber: Barber
    let price: String
    let status: String
    let paymentMethod: String
    let phoneNumber: String
    
    var fullTime: String { "\(month) \(day), \(time)" }
    var shopName: String { barber.name }
}
