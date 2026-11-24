//
//  MapView.swift
//  TheBarber
//
//  Created by Jaloliddin Esonboyev on 16/08/2026.
//

import SwiftUI
import MapKit

struct MapView: View {
    @StateObject private var viewModel = MapViewModel()
    
    var body: some View {
        NavigationStack {
            Map(position: $viewModel.position) {
                ForEach(viewModel.filteredBarbers) { item in
                    Annotation(item.barber.name, coordinate: item.coordinate) {
                        Button(action: {
                            withAnimation(.spring(response: 0.35, dampingFraction: 0.75)) {
                                viewModel.selectedBarber = item.barber
                            }
                        }) {
                            CustomMapAnnotation(
                                icon: "scissors",
                                distance: item.distance
                                
                            )
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .navigationTitle("Barbers")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $viewModel.searchText, prompt: "Search barbers")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        viewModel.recenterMap()
                    }) {
                        Image(systemName: "location.circle")
                    }
                }
            }
            
            .sheet(item: $viewModel.selectedBarber) { barber in
                    NavigationStack {
                        BarberDetailView(
                            barber: barber,
                            selectedTab: .constant(2),
                            navPath: .constant(NavigationPath())
                        )
                        .toolbar {
                            ToolbarItem(placement: .topBarLeading) {
                                Button("Done") {
                                    viewModel.dismissSelectedBarber()
                                }
                                .bold()
                            }
                        }
                    }
                }
            }
    }
}

struct CustomMapAnnotation: View {
    let icon: String
    let distance: String
    
    var body: some View {
        VStack(spacing: 4) {
            ZStack {
                Circle()
                    .fill(Color(icon == "scissors" ? .darkGray : .lightGray))
                    .frame(width: 44, height: 44)
                    .overlay(
                        Circle().stroke(Color.white, lineWidth: 3)
                    )
                    .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
                
                Image(systemName: icon)
                    .foregroundColor(.white)
                    .font(.title3)
            }
            Text(distance)
                .font(.caption)
                .foregroundColor(.black)
                .fontWeight(.bold)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color.white)
                .clipShape(Capsule())
                .shadow(color: .black.opacity(0.15), radius: 3, x: 0, y: 1)
        }
    }
}

#Preview {
    MapView()
        .environmentObject(SavedBarbersManager())
}
