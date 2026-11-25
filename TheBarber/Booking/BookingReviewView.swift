//
//  BookReviewView.swift
//  TheBarber
//
//  Created by Jaloliddin Esonboyev on 13/08/2026.
//

import SwiftUI

struct BookingReviewView: View {
    @StateObject private var viewModel: BookingReviewViewModel
    
    @Binding var selectedTab: Int
    @Binding var navPath: NavigationPath
    
    @EnvironmentObject var bookingsManager: BookingsManager
    @EnvironmentObject var notificationsViewModel: NotificationsViewModel

    init(
        barber: Barber,
        selectedDate: Date,
        selectedTime: String,
        selectedTab: Binding<Int>,
        navPath: Binding<NavigationPath>
    ) {
        _viewModel = StateObject(wrappedValue: BookingReviewViewModel (
            barber: barber,
            selectedDate: selectedDate,
            selectedTime: selectedTime
        ))
        self._selectedTab = selectedTab
        self._navPath = navPath
    }
    
    var body: some View {
        VStack {
            Form {
                Section {
                    LabeledContent("Barber / Shop Name", value: viewModel.barber.name)
                    LabeledContent("Price Range", value: "$\(viewModel.barber.price) - $\(viewModel.barber.price + 50)")
                    LabeledContent("Phone Number", value: viewModel.contactPhone)
                    LabeledContent("Appointment Time", value: viewModel.appointmentTimeDisplay)
                }
                
                Section {
                    Picker("Payment method", selection: $viewModel.paymentMethod) {
                        ForEach(viewModel.paymentMethods, id: \.self) { method in
                            Text(method).tag(method)
                        }
                    }
                }
            }
            .listSectionSpacing(.compact)
            
            
            Button( action: {
                viewModel.confirmBooking(
                    bookingsManager: bookingsManager,
                    notificationsViewModel: notificationsViewModel
                ) {
                    navPath.append(AppRoute.success)
                }
            }) {
                Text("Confirm booking")
                    .font(.headline)
                    .bold()
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 52)
                    .background(Color.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 16)
        }
        .navigationTitle("Confirm booking")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        BookingReviewView(
            barber: Barber(
                name: "John Barber",
                location: "Charlie street",
                price: 120,
                distance: "7km",
                rating: 4.5,
                imageName: "barber1"
            ),
            selectedDate: Date(),
            selectedTime: "12:00",
            selectedTab: .constant(0),
            navPath: .constant(NavigationPath())
        )
        .environmentObject(BookingsManager())
        .environmentObject(NotificationsViewModel())
    }
}
