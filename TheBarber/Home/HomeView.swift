//
//  HomeView.swift
//  TheBarber
//
//  Created by Jaloliddin Esonboyev on 12/08/2026.
//

import SwiftUI

enum AppRoute: Hashable {
    case detail(Barber)
    case review(Barber, Date, String)
    case success
}

struct HomeView: View {
    @State private var showingFilterSheet = false
    @State private var showingNotificationsSheet = false
    @Binding var selectedTab: Int
    @Binding var navPath: NavigationPath
    
    let barbers: [Barber] = [
        Barber(name: "John Barbershop", location: "Main street Avenue", price: 120, rating: 4.5, imageName: "barber1"),
        Barber(name: "The Barber's Den", location: "Warszawa Centralna", price: 70, rating: 4.8, imageName: "barber2"),
        Barber(name: "The Hair Station", location: "Suzy's Garden", price: 100, rating: 3.9, imageName: "barber3"),
        Barber(name: "The Gentleman's Club", location: "Tenerife Sea", price: 80, rating: 4.2, imageName: "barber4"),
        Barber(name: "John Barbershop", location: "Main street Avenue", price: 120, rating: 4.5, imageName: "barber6"),
        Barber(name: "The Barber's Den", location: "Warszawa Centralna", price: 70, rating: 4.8, imageName: "barber5"),
        Barber(name: "The Hair Station", location: "Suzy's Garden", price: 100, rating: 3.9, imageName: "barber7"),
        Barber(name: "The Gentleman's Club", location: "Tenerife Sea", price: 80, rating: 4.2, imageName: "barber8")
    ]
    
    let gridColumns = [
        GridItem(.flexible(), spacing: 14),
        GridItem(.flexible(), spacing: 14)
    ]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                
                Text("Top Barbers")
                    .font(.largeTitle)
                    .bold()
                    .padding(.horizontal)
                
                LazyVGrid(columns: gridColumns, spacing: 14) {
                    ForEach(barbers) { barber in
                        NavigationLink(value: AppRoute.detail(barber)) {
                            BarberCardView(barber: barber)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    showingFilterSheet = true
                }) {
                    Image(systemName: "line.3.horizontal.decrease.circle")
                        .font(.title3)
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    showingNotificationsSheet = true
                }) {
                    Image(systemName: "bell")
                        .font(.title3)
                }
            }
        }
        .sheet(isPresented: $showingFilterSheet) {
            FilterView()
        }
        .sheet(isPresented: $showingNotificationsSheet) {
            NotificationsView()
        }
        
        .navigationDestination(for: AppRoute.self) { route in
            switch route {
            case .detail(let barber):
                BarberDetailView(barber: barber, selectedTab: $selectedTab, navPath: $navPath)
            case .review(let barber, let date, let time):
                BookingReviewView(barber: barber, selectedDate: date, selectedTime: time, selectedTab: $selectedTab, navPath: $navPath)
            case .success:
                BookingSuccessView(selectedTab: $selectedTab, navPath: $navPath)
            }
        }
    }
}

#Preview {
    NavigationStack {
        HomeView(selectedTab: .constant(0), navPath: .constant(NavigationPath()))
    }
}
