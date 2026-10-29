//
//  MapView.swift
//  TheBarber
//
//  Created by Jaloliddin Esonboyev on 16/08/2026.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State private var searchText = ""
    
    @State private var position: MapCameraPosition = .region(MKCoordinateRegion (
        center: CLLocationCoordinate2D(latitude: 52.2357, longitude: 21.0150),
        span: MKCoordinateSpan(latitudeDelta: 0.04, longitudeDelta: 0.04)
    ))
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                Map(position: $position) {
                    Annotation("", coordinate: CLLocationCoordinate2D(latitude: 52.2317, longitude: 21.0062)) {
                        CustomMapAnnotation(icon: "scissors", distance: "2 km")
                    }
                    
                    Annotation("", coordinate: CLLocationCoordinate2D(latitude: 52.2420, longitude: 21.0170)) {
                        CustomMapAnnotation(icon: "scissors", distance: "1.2 km")
                    }
                    
                    Annotation("", coordinate: CLLocationCoordinate2D(latitude: 52.2290, longitude: 21.0210)) {
                        CustomMapAnnotation(icon: "scissors", distance: "0.2 km")
                    }
                }
                .navigationTitle("Barbers")
                .navigationBarTitleDisplayMode(.inline)
                .searchable(text: $searchText, prompt: "Search barbers")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            //action
                        }) {
                            Image(systemName: "slider.horizontal.3")
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
}
