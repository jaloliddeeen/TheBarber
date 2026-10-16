//
//  BookingsView.swift
//  TheBarber
//
//  Created by Jaloliddin Esonboyev on 16/08/2026.
//

import SwiftUI

struct Booking: Identifiable {
    let id = UUID()
    let month: String
    let day: String
    let time: String
    var fullTime: String { "\(month) \(day), \(time)" }
    let shopName: String
    let price: String
    let status: String
    let paymentMethod: String
    let phoneNumber: String
}

struct BookingsView: View {
    @State private var selectedTab = "Active"
    @State private var selectedBooking: Booking?
    
    let tabs = ["Active", "Inactive"]
    
    let activeBookings = [
        Booking(month: "SEP", day: "8", time: "12:05", shopName: "John Barbershop", price: "$65", status: "Confirmed", paymentMethod: "Cash", phoneNumber: "+48 726-273-188"),
        Booking(month: "SEP", day: "19", time: "17:00", shopName: "Suzy's style", price: "$85", status: "Confirmed", paymentMethod: "Card", phoneNumber: "+48 382-233-658")
    ]
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                Picker("Status", selection: $selectedTab) {
                    ForEach(tabs, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                .padding(.vertical, 8)
                
                ScrollView {
                    VStack(spacing: 12) {
                        if selectedTab == "Active" {
                            ForEach(activeBookings) { booking in
                                BookingCardView(booking: booking) {
                                    selectedBooking = booking
                                }
                            }
                        } else {
                            ContentUnavailableView(
                                "No active bookings",
                                systemImage: "calendar.badge.clock",
                                description: Text("Past appointments will appear here")
                            )
                            .padding(.top, 160)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 8)
                }
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("My bookings")
            .sheet(item: $selectedBooking) { booking in
                BookingDetailSheet(booking: booking)
                    .presentationDetents([.fraction(0.65), .large])
                    .presentationDragIndicator(.visible)
            }
        }
    }
}

struct BookingCardView: View {
    let booking: Booking
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 14) {
                VStack(spacing: 2) {
                    Text(booking.month)
                        .font(.caption2)
                        .fontWeight(.heavy)
                        .foregroundColor(.red)
                    Text(booking.day)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                }
                .frame(width: 52, height: 56)
                .background(Color(.tertiarySystemGroupedBackground))
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(booking.shopName)
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        Spacer()
                        
                        Text(booking.status)
                            .font(.caption2)
                            .fontWeight(.semibold)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 3)
                            .background(Color.green.opacity(0.12))
                            .foregroundColor(.green)
                            .clipShape(Capsule())
                    }
                    
                    HStack(spacing: 6) {
                        Text(booking.time)
                        Text("•")
                        Text(booking.price)
                        Text("•")
                        Text(booking.paymentMethod)
                    }
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                }
                
                Image(systemName: "chevron.right")
                    .font(.footnote.weight(.semibold))
                    .foregroundColor(Color(.tertiaryLabel))
            }
            .padding(14)
            .background(Color(.secondarySystemGroupedBackground))
            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
        }
        .buttonStyle(.plain)
    }
}

struct BookingDetailSheet: View {
    let booking: Booking
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                VStack(alignment: .leading, spacing: 16) {
                    DetailRowView(title: "Barber / Shop Name", icon: "building.2", value: booking.shopName, showChevron: true)
                    
                    Divider()
                    
                    DetailRowView(title: "Price", icon: "banknote", value: booking.price)
                    
                    Divider()
                    
                    DetailRowView(title: "Payment Method", icon: "creditcard", value: booking.paymentMethod)
                    
                    Divider()
                    
                    DetailRowView(title: "Phone Number", icon: "phone", value: booking.phoneNumber)
                }
                .padding()
                .background(Color(.secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                
                Spacer()
                
                Button(action: {
                    //
                }) {
                    Text("Cancel booking")
                        .font(.headline)
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity)
                        .frame(height: 52)
                        .overlay (
                            RoundedRectangle(cornerRadius: 14)
                                .stroke(Color.red, lineWidth: 1)
                        )
                }
            }
            .padding()
            .navigationTitle("Booking: \(booking.fullTime)")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                            .font(.body.bold())
                            .foregroundColor(.secondary)
                    }
                }
                
            }
        }
    }
}

struct DetailRowView: View {
    let title: String
    let icon: String
    let value: String
    var showChevron: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.caption)
                .fontWeight(.semibold)
            
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .foregroundColor(.blue)
                    .frame(width: 20)
                
                Text(value)
                    .font(.body)
                
                Spacer()
                
                if showChevron {
                    Image(systemName: "chevron.right")
                        .font(.body)
                        .foregroundColor(.secondary)
                }
            }
        }
    }
}

#Preview {
    MainTabView()
}
