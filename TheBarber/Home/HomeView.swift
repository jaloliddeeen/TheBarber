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
    @State private var filterOptions = FilterOptions()
    
    @Binding var selectedTab: Int
    @Binding var navPath: NavigationPath
    
    let barbers: [Barber] = [
        Barber(name: "John Barbershop", location: "Main street Avenue, 11", price: 120, distance: "2 km", rating: 4.5, imageName: "barber1"),
        Barber(name: "Beauty salon", location: "Warsaw Center", price: 70, distance: "8 km", rating: 4.8, imageName: "barber2"),
        Barber(name: "The Hair Station", location: "Brookfield 27", price: 100, distance: "11 km", rating: 3.9, imageName: "barber3"),
        Barber(name: "The Gentleman's Club", location: "Riverfood Av.", price: 80, distance: "5 km", rating: 4.2, imageName: "barber4"),
        Barber(name: "Master Olivia", location: "Northbridge", price: 105, distance: "6 km", rating: 4.5, imageName: "barber6"),
        Barber(name: "The barber's Den", location: "Lakeside st.", price: 65, distance: "1 km", rating: 4.8, imageName: "barber5"),
        Barber(name: "Chloe Hayes", location: "Maple Creek", price: 150, distance: "8 km", rating: 3.9, imageName: "barber7"),
        Barber(name: "Lucas's Space", location: "Oakridge 611A", price: 95, distance: "4 km", rating: 4.2, imageName: "barber8"),
        Barber(name: "Master Olivia", location: "Northbridge", price: 105, distance: "6 km", rating: 4.5, imageName: "barber9"),
        Barber(name: "The barber's Den", location: "Lakeside st.", price: 65, distance: "1 km", rating: 4.8, imageName: "barber10"),
        Barber(name: "Chloe Hayes", location: "Maple Creek", price: 150, distance: "8 km", rating: 3.9, imageName: "barber11"),
        Barber(name: "Lucas's Space", location: "Oakridge 611A", price: 95, distance: "4 km", rating: 4.2, imageName: "barber12")
    ]
    
    let gridColumns = [
        GridItem(.flexible(), spacing: 14),
        GridItem(.flexible(), spacing: 14)
    ]
    
    private var filteredBarbers: [Barber] {
        var list = barbers.filter { barber in
            Double(barber.price) <= filterOptions.maxPrice &&
            barber.rating >= filterOptions.minRating
        }
        
        switch filterOptions.sortBy {
        case .recommended:
            break
        case .highestRated:
            list.sort { $0.rating > $1.rating }
        case .priceLowToHigh:
            list.sort { $0.price < $1.price }
        case .priceHighToLow:
            list.sort { $0.price > $1.price }
        }
        
        return list
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 8) {
                
                Text("Top Barbers")
                    .font(.largeTitle)
                    .bold()
                    .padding(.horizontal)
                
                if filteredBarbers.isEmpty {
                    ContentUnavailableView {
                        Label("No Barbers Found", systemImage: "line.3.horizontal.decrease.circle")
                    } description: {
                        Text("Try adjusting your price or rating filters.")
                    } actions: {
                        Button("Reset Filters") {
                            withAnimation {
                                filterOptions.reset()
                            }
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .padding(.top, 40)
                } else {
                    LazyVGrid(columns: gridColumns, spacing: 14) {
                        ForEach(filteredBarbers) { barber in
                            NavigationLink(value: AppRoute.detail(barber)) {
                                BarberCardView(barber: barber)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .padding(.vertical)
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    showingFilterSheet = true
                }) {
                    Image(systemName: filterOptions.isFiltered ? "line.3.horizontal.decrease.circle.fill" : "line.3.horizontal.decrease.circle")
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
            FilterView(filterOptions: $filterOptions)
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
