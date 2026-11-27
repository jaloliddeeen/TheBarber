//
//  SavedBarbersView.swift
//  TheBarber
//
//  Created by Jaloliddin Esonboyev on 27/10/2026.
//

import SwiftUI

struct SavedBarbersView: View {
    @EnvironmentObject var savedManager: SavedBarbersManager
    @Environment(\.dismiss) private var dismiss
    
    let gridColumns = [
        GridItem(.flexible(), spacing: 14),
        GridItem(.flexible(), spacing: 14)
    ]
    
    var body: some View {
        Group {
            if savedManager.savedBarbers.isEmpty {
                EmptyStateView.noSavedBarbers {
                    dismiss()
                }
            } else {
                ScrollView{
                    BarberGridView(barbers: savedManager.savedBarbers)
                        .padding(.vertical)
                }
            }
        }
        .navigationTitle("Saved Barbers")
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(for: AppRoute.self) { route in
            switch route {
            case .detail(let barber):
                BarberDetailView(
                    barber: barber,
                    selectedTab: .constant(3),
                    navPath: .constant(NavigationPath())
                )
            default:
                EmptyView()
            }
        }
    }
}

#Preview {
    NavigationStack {
        SavedBarbersView()
            .environmentObject(SavedBarbersManager())
    }
}
