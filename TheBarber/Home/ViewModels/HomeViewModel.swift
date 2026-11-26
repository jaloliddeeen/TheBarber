//
//  HomeViewModel.swift
//  TheBarber
//
//  Created by Jaloliddin Esonboyev on 23/11/2026.
//

import SwiftUI

@MainActor
class HomeViewModel: ObservableObject {
    @Published var filterOptions = FilterOptions()
    
    @Published var barbers: [Barber] = [
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
    
    var filteredBarbers: [Barber] {
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
    
    var isFiltered: Bool {
        filterOptions.isFiltered
    }
    
    func resetFilters() {
        filterOptions.reset()
    }
}

