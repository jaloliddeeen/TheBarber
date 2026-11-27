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
    @StateObject private var viewModel = HomeViewModel()
    
    @State private var showingFilterSheet = false
    @State private var showingNotificationsSheet = false
    
    @Binding var selectedTab: Int
    @Binding var navPath: NavigationPath
    
    let gridColumns = [
        GridItem(.flexible(), spacing: 14),
        GridItem(.flexible(), spacing: 14)
    ]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 8) {
                
                Text("Top Barbers")
                    .font(.largeTitle)
                    .bold()
                    .padding(.horizontal)
                
                if viewModel.filteredBarbers.isEmpty {
                    EmptyStateView.noFilterResults {
                        withAnimation {
                            viewModel.filterOptions.reset()
                        }
                    }
                } else {
                    BarberGridView(barbers: viewModel.filteredBarbers)
                }
            }
            .padding(.vertical)
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    showingFilterSheet = true
                }) {
                    Image(systemName: viewModel.filterOptions.isFiltered ? "line.3.horizontal.decrease.circle.fill" : "line.3.horizontal.decrease.circle")
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
            FilterView(filterOptions: $viewModel.filterOptions)
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

struct BarberGridView: View {
    let barbers: [Barber]
    
    private let gridColumns = [
        GridItem(.flexible(), spacing: 14),
        GridItem(.flexible(), spacing: 14)
    ]
    
    var body: some View {
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
}


struct FilterToolbarButton: View {
    let isFiltered: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: isFiltered ? "line.3.horizontal.decrease.circle.fill" : "line.3.horizontal.decrease.circle")
                .font(.title3)
        }
    }
}


#Preview {
    NavigationStack {
        HomeView(selectedTab: .constant(0), navPath: .constant(NavigationPath()))
    }
}
