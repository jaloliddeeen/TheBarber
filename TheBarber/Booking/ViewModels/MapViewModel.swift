//
//  MapViewModel.swift
//  TheBarber
//
//  Created by Jaloliddin Esonboyev on 24/11/2026.
//

import SwiftUI
import MapKit

@MainActor
class MapViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var selectedBarber: Barber?
    @Published var position: MapCameraPosition
    
    static let warsawCenter = CLLocationCoordinate2D(latitude: 52.2370, longitude: 21.0080)
    static let defaultSpan = MKCoordinateSpan(latitudeDelta: 0.045, longitudeDelta: 0.045)
    
    @Published var barbers: [MapBarberLocation] = [
        MapBarberLocation(
            barber: Barber(name: "1SECONDCUT Barbershop", location: "ul. Marszałkowska 85, Warsaw", price: 90, distance: "1 km", rating: 4.9, imageName: "barber1"),
            coordinate: CLLocationCoordinate2D(latitude: 52.2272, longitude: 21.0142),
            distance: "1.1 km"
        ),
        MapBarberLocation(
            barber: Barber(name: "Ferajna Barber Shop", location: "ul. Nowolipie 13/15, Warsaw", price: 120, distance: "4 km", rating: 4.8, imageName: "barber4"),
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
    
    init() {
        self.position = .region(MKCoordinateRegion(
            center: Self.warsawCenter,
            span: Self.defaultSpan
        ))
    }
    
    var filteredBarbers: [MapBarberLocation] {
        let query = searchText.trimmingCharacters(in: .whitespaces)
        guard !query.isEmpty else { return barbers }
        
        return barbers.filter {
            $0.barber.name.localizedCaseInsensitiveContains(query) ||
            $0.barber.location.localizedCaseInsensitiveContains(query)
        }
    }
    
    func recenterMap() {
        withAnimation {
            position = .region(MKCoordinateRegion(
                center: Self.warsawCenter,
                span: Self.defaultSpan
            ))
        }
    }
    
    func selectBarber(_ barber: Barber) {
        withAnimation(.spring(response: 0.35, dampingFraction: 0.75)) {
            selectedBarber = barber
        }
    }
    
    func dismissSelectedBarber() {
        selectedBarber = nil
    }
}
