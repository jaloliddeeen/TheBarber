//
//  MapView.swift
//  TheBarber
//
//  Created by Jaloliddin Esonboyev on 16/08/2026.
//

import SwiftUI
import MapKit

struct MapBarberLocation: Identifiable {
    let id = UUID()
    let barber: Barber
    let coordinate: CLLocationCoordinate2D
    let distance: String
}

struct MapView: View {
    @State private var searchText = ""
    
    @State private var selectedBarber: Barber?
    
    @State private var position: MapCameraPosition = .region(MKCoordinateRegion (
        center: CLLocationCoordinate2D(latitude: 52.2370, longitude: 21.0080),
        span: MKCoordinateSpan(latitudeDelta: 0.045, longitudeDelta: 0.045)
    ))
    
    
    let warsawBarbers: [MapBarberLocation] = [
        MapBarberLocation(
            barber: Barber(name: "1SECONDCUT Barbershop", location: "ul. Marszałkowska 85, Warsaw", price: 90, distance: "1 km", rating: 4.9, imageName: "barber1"),
            coordinate: CLLocationCoordinate2D(latitude: 52.2272, longitude: 21.0142),
            distance: "1.1 km"
        ),
        MapBarberLocation(
            barber: Barber(name: "Ferajna Barber Shop", location: "ul. Nowolipie 13/15, Warsaw", price: 120, distance: " 4 km", rating: 4.8, imageName: "barber4"),
            coordinate: CLLocationCoordinate2D(latitude: 52.2425, longitude: 20.9982),
            distance: "1.2 km"
        ),
        MapBarberLocation(
            barber: Barber(name: "One Shot Barber", location: "ul. Długa 8/14, Warsaw", price: 95, distance: "5 km", rating: 4.9, imageName: "barber5"),
            coordinate: CLLocationCoordinate2D(latitude: 52.2482, longitude: 21.0041),
            distance: "1.9 km"
        ),
        
        MapBarberLocation(
            barber: Barber(name: "The Barber's Den", location: "ul. Nowy Świat 35, Warsaw", price: 85, distance: "4 km", rating: 4.8, imageName: "barber5"),
            coordinate: CLLocationCoordinate2D(latitude: 52.2335, longitude: 21.0198),
            distance: "0.7 km"
        ),
        MapBarberLocation(
            barber: Barber(name: "John Barbershop", location: "ul. Złota 11, Warsaw", price: 110, distance: "5 km", rating: 4.5, imageName: "barber6"),
            coordinate: CLLocationCoordinate2D(latitude: 52.2312, longitude: 21.0112),
            distance: "0.3 km"
        ),
        MapBarberLocation(
            barber: Barber(name: "The Hair Station", location: "ul. Chmielna 14, Warsaw", price: 95, distance: "6 km", rating: 4.3, imageName: "barber7"),
            coordinate: CLLocationCoordinate2D(latitude: 52.2318, longitude: 21.0165),
            distance: "0.5 km"
        ),
        MapBarberLocation(
            barber: Barber(name: "The Gentleman's Club", location: "ul. Mokotowska 45, Warsaw", price: 125, distance: "7 km", rating: 4.6, imageName: "barber8"),
            coordinate: CLLocationCoordinate2D(latitude: 52.2230, longitude: 21.0210),
            distance: "1.4 km"
        ),
        
        MapBarberLocation(
            barber: Barber(name: "Old Town Barber", location: "ul. Senatorska 22, Warsaw", price: 100, distance: "2 km", rating: 4.8, imageName: "barber4"),
            coordinate: CLLocationCoordinate2D(latitude: 52.2440, longitude: 21.0080),
            distance: "1.1 km"
        )
    ]
    
    private var filteredBarbers: [MapBarberLocation] {
        if searchText.trimmingCharacters(in: .whitespaces).isEmpty {
            return warsawBarbers
        } else {
            return warsawBarbers.filter {
                $0.barber.name.localizedCaseInsensitiveContains(searchText) ||
                $0.barber.location.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            Map(position: $position) {
                ForEach(filteredBarbers) { item in
                    Annotation(item.barber.name, coordinate: item.coordinate) {
                        Button(action: {
                            withAnimation(.spring(response: 0.35, dampingFraction: 0.75)) {
                                selectedBarber = item.barber
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
            .searchable(text: $searchText, prompt: "Search barbers")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        withAnimation {
                            position = .region(MKCoordinateRegion(
                                center: CLLocationCoordinate2D(latitude: 52.2370, longitude: 21.0080),
                                span: MKCoordinateSpan(latitudeDelta: 0.045, longitudeDelta: 0.045)
                            ))
                        }
                    }) {
                        Image(systemName: "location.circle")
                    }
                }
            }
            
            .sheet(item: $selectedBarber) { barber in
                NavigationStack {
                    BarberDetailView(
                        barber: barber,
                        selectedTab: .constant(2),
                        navPath: .constant(NavigationPath())
                    )
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Button("Done") {
                                selectedBarber = nil
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
