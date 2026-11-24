//
//  FilterOptions.swift
//  TheBarber
//
//  Created by Jaloliddin Esonboyev on 24/11/2026.
//

import Foundation

struct FilterOptions: Equatable {
    var maxPrice: Double = 150
    var minRating: Double = 0.0
    var sortBy: SortOption = .recommended
    
    enum SortOption: String, CaseIterable, Identifiable {
        case recommended = "Recommended"
        case highestRated = "Highest rated"
        case priceLowToHigh = "Price low to high"
        case priceHighToLow = "Price high to low"
        
        var id: String { rawValue }
    }
    
    var isFiltered: Bool {
        maxPrice < 150 || minRating > 0.0 || sortBy != .recommended
    }
    
    mutating func reset() {
        maxPrice = 150
        minRating = 0.0
        sortBy = .recommended
    }
}
