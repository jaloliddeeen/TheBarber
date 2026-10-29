//
//  SavedBarbersView.swift
//  TheBarber
//
//  Created by Jaloliddin Esonboyev on 27/10/2026.
//

import SwiftUI

struct SavedBarbersView: View {
    @EnvironmentObject var savedManager: SavedBarbersManager
    
    // Identical grid configuration as HomeView
    let gridColumns = [
        GridItem(.flexible(), spacing: 14),
        GridItem(.flexible(), spacing: 14)
    ]
    
    var body: some View {
        Group {
            if savedManager.savedBarbers.isEmpty {
                // Native iOS 17 Empty State
                ContentUnavailableView(
                    "No Saved Barbers",
                    systemImage: "bookmark.slash",
                    description: Text("Barbers you bookmark will appear here for quick booking.")
                )
            } else {
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        LazyVGrid(columns: gridColumns, spacing: 14) {
                            ForEach(savedManager.savedBarbers) { barber in
                                NavigationLink(destination: BarberDetailView(
                                    barber: barber,
                                    selectedTab: .constant(3),
                                    navPath: .constant(NavigationPath())
                                )) {
                                    BarberCardView(barber: barber)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(.horizontal)
                    }
                    .padding(.vertical)
                }
            }
        }
        .navigationTitle("Saved Barbers")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        SavedBarbersView()
            .environmentObject(SavedBarbersManager())
    }
}
