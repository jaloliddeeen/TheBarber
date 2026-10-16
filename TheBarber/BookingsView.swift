//
//  BookingsView.swift
//  TheBarber
//
//  Created by Jaloliddin Esonboyev on 16/08/2026.
//

import SwiftUI

struct Booking: Identifiable {
    let id = UUID()
    let date: String
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
        Booking(date: "September 8, 12:00", shopName: "John Barbershop", price: "$65", status: "Confirmed", paymentMethod: "Cash", phoneNumber: "+48 726-273-188"),
        Booking(date: "October 12, 12:00", shopName: "Suzy's style", price: "$85", status: "Confirmed", paymentMethod: "Card", phoneNumber: "+48 382-233-658")
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Picker("Status", selection: $selectedTab) {
                        ForEach(tabs, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding()
                    
                    ScrollView {
                        VStack(spacing: 16) {
                            if selectedTab == "Active" {
                                ForEach(activeBookings) { booking in
                                    BookingCardView(booking: booking) {
                                        selectedBooking = booking
                                    }
                                }
                            } else {
                                Text("No active bookings")
                                    .foregroundColor(.secondary)
                                    .padding()
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
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
    let onViewDetails: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(booking.date)
                    .font(.headline)
                
                Spacer()
                
                Text(booking.status)
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.green)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Barbershop: \(booking.shopName)")
                    .foregroundColor(.secondary)
                Text("Total price: \(booking.price)")
                    .foregroundColor(.secondary)
            }
            .font(.subheadline)
            
            Button(action: {
                onViewDetails()
            }) {
                HStack {
                    Text("View details")
                    Image(systemName: "arrow.right")
                }
                .font(.subheadline)
                .fontWeight(.medium)
            }
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(.systemGray5), lineWidth: 1)
        )
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
            .navigationTitle("Booking: \(booking.date)")
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
