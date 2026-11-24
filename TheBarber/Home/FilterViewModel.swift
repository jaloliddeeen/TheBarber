//
//  FilterViewModel.swift
//  TheBarber
//
//  Created by Jaloliddin Esonboyev on 24/11/2026.
//

import SwiftUI

@MainActor
class FilterViewModel: ObservableObject {
    @Published var draftOptions: FilterOptions
    
    let ratingOptions: [(label: String, value: Double)] = [
        ("All", 0.0),
        ("4.0+", 4.0),
        ("4.5+", 4.5),
        ("4.8+", 4.8)
    ]
    
    var canReset: Bool {
        draftOptions.isFiltered
    }
    
    private let onApply: (FilterOptions) -> Void
    
    init(initialOptions: FilterOptions, onApply: @escaping (FilterOptions) -> Void) {
        self.draftOptions = initialOptions
        self.onApply = onApply
    }
    
    func reset() {
        withAnimation {
            draftOptions.reset()
        }
    }
    
    func apply() {
        onApply(draftOptions)
    }
}
