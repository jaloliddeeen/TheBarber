//
//  BarberApplication.swift
//  TheBarber
//
//  Created by Jaloliddin Esonboyev on 25/11/2026.
//

import Foundation

public enum BarberSpecialization: String, CaseIterable, Identifiable {
    case allRound = "All-round Barber"
    case classic = "Classic Haircuts"
    case beardGrooming = "Beard Grooming"
    case hotTowelShave = "Hot Towel Shave"
    case hairColoring = "Hair Coloring"
    
    public var id: String { rawValue }
}

public struct BarberApplication: Identifiable, Equatable {
    public let id: UUID
    public let fullName: String
    public let email: String
    public let phoneNumber: String
    public let workPlace: String
    public let yearsOfExperience: Int
    public let specialization: BarberSpecialization
    public let instagramHandle: String?
    public let additionalNotes: String?
    public let submittedAt: Date
    
    public init(
        id: UUID = UUID(),
        fullName: String,
        email: String,
        phoneNumber: String,
        workPlace: String,
        yearsOfExperience: Int,
        specialization: BarberSpecialization,
        instagramHandle: String? = nil,
        additionalNotes: String? = nil,
        submittedAt: Date = Date()
    ) {
        self.id = id
        self.fullName = fullName
        self.email = email
        self.phoneNumber = phoneNumber
        self.workPlace = workPlace
        self.yearsOfExperience = yearsOfExperience
        self.specialization = specialization
        self.instagramHandle = instagramHandle
        self.additionalNotes = additionalNotes
        self.submittedAt = submittedAt
    }
}
