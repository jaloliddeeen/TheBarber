//
//  SavedBarbersManager.swift
//  TheBarber
//
//  Created by Jaloliddin Esonboyev on 27/10/2026.
//

import Foundation

class SavedBarbersManager: ObservableObject {
    @Published var savedBarbers: [Barber] = [
        Barber(name: "John barbershop", location: "Main street avenue", price: 120, rating: 4.5, imageName: "barber1")
    ]
    
    func isSaved(_ barber: Barber) -> Bool {
        savedBarbers.contains(where: { $0.name == barber.name })
    }
    
    func toggleSave(_ barber: Barber) {
        if let index = savedBarbers.firstIndex(where: {$0.name == barber.name}) {
            savedBarbers.remove(at: index)
        } else {
            savedBarbers.append(barber)
        }
    }
}
