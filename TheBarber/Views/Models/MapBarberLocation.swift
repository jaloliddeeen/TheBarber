//
//  MapBarberLocation.swift
//  TheBarber
//
//  Created by Jaloliddin Esonboyev on 24/11/2026.
//

import Foundation
import CoreLocation

struct MapBarberLocation: Identifiable {
    let id = UUID()
    let barber: Barber
    let coordinate: CLLocationCoordinate2D
    let distance: String
}
