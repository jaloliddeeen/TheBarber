//
//  MainTabView.swift
//  TheBarber
//
//  Created by Jaloliddin Esonboyev on 11/08/2026.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0
    @State private var navPath = NavigationPath()
    
    @StateObject private var bookingsManager = BookingsManager()
    @StateObject private var savedManager = SavedBarbersManager()
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationStack(path: $navPath) {
                HomeView(selectedTab: $selectedTab, navPath: $navPath)
            }
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }
            .tag(0)
            
            NavigationStack {
                BookingsView()
            }
            .tabItem {
                Label("Bookings", systemImage: "calendar")
            }
            .tag(1)
            
            NavigationStack {
                MapView()
            }
            .tabItem {
                Label("Map", systemImage: "map")
            }
            .tag(2)
            
            NavigationStack {
                ProfileView()
            }
            .tabItem {
                Label("Profile", systemImage: "person.crop.circle")
            }
            .tag(3)
        }
        .environmentObject(savedManager)
        .environmentObject(bookingsManager)
    }
}

#Preview {
    MainTabView()
}
