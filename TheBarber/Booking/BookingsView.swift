//
//  BookingsView.swift
//  TheBarber
//
//  Created by Jaloliddin Esonboyev on 16/08/2026.
//

import SwiftUI

struct BookingsView: View {
    @StateObject private var viewModel = BookingsViewModel()
    @EnvironmentObject var bookingsManager: BookingsManager
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                Picker("Status", selection: $viewModel.selectedTab) {
                    ForEach(BookingsViewModel.BookingTab.allCases) { tab in
                        Text(tab.rawValue).tag(tab)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                .padding(.vertical, 8)
                
                ScrollView {
                    VStack(spacing: 12) {
                        switch viewModel.selectedTab {
                        case .active:
                            if bookingsManager.activeBookings.isEmpty {
                                EmptyStateView.noActiveBookings
                            } else {
                                ForEach(bookingsManager.activeBookings) { booking in
                                    BookingCardView(booking: booking) {
                                        viewModel.selectedBooking = booking
                                    }
                                }
                            }
                        case .inactive:
                            EmptyStateView.noInactiveBookings
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 8)
                }
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("My bookings")
            .sheet(item: $viewModel.selectedBooking) { booking in
                BookingDetailSheet(booking: booking) {
                    viewModel.cancelBooking(booking, in: bookingsManager)
                }
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
    var onCancel: () -> Void
    @Environment(\.dismiss) var dismiss
    @State private var showCancelAlert = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                VStack(alignment: .leading, spacing: 16) {
                    NavigationLink {
                        BarberDetailView(
                            barber: booking.barber,
                            selectedTab: .constant(1),
                            navPath: .constant(NavigationPath())
                        )
                    } label: {
                        DetailRowView(title: "Barber / Shop Name", icon: "building.2", value: booking.shopName, showChevron: true)
                    }
                    .buttonStyle(.plain)
                    
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
                    showCancelAlert = true
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
            .alert("Cancel booking?", isPresented: $showCancelAlert) {
                Button("Cancel appointment", role: .destructive) {
                    onCancel()
                    dismiss()
                }
                Button("Keep booking", role: .cancel) { }
            } message: {
                Text("Are you sure you want to cancel your appointment with \(booking.shopName)?")
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
    BookingsView()
        .environmentObject(BookingsManager())
        .environmentObject(SavedBarbersManager())
}

