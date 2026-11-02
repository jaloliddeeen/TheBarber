//
//  FilterView.swift
//  TheBarber
//
//  Created by Jaloliddin Esonboyev on 12/08/2026.
//

import SwiftUI

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

struct FilterView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @Binding var filterOptions: FilterOptions
    
    @State private var tempOptions: FilterOptions = FilterOptions()
    
    let ratingOptions: [(label: String, value: Double)] = [
        ("All", 0.0),
        ("4.0+", 4.0),
        ("4.5+", 4.5),
        ("4.8+", 4.8)
    ]
    
    var body: some View {
        NavigationStack{
            Form {
                Section("Sort by") {
                    Picker("Sort by", selection: $tempOptions.sortBy) {
                        ForEach(FilterOptions.SortOption.allCases) { option in
                            Text(option.rawValue).tag(option)
                        }
                    }
                    .pickerStyle(.menu)
                }
                
                Section("Filter by price") {
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text("Max price")
                            Spacer()
                            Text("$\(Int(tempOptions.maxPrice))")
                                .font(.headline)
                                .foregroundColor(.blue)
                        }
                        Slider(value: $tempOptions.maxPrice, in: 50...150, step: 5)
                    }
                    .padding(.vertical, 4)
                }
                
                Section("Minimum rating") {
                    Picker("Rating", selection: $tempOptions.minRating) {
                        ForEach(ratingOptions, id: \.value) { option in
                            Text(option.label).tag(option.value)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section {
                    Button(action: {
                        filterOptions = tempOptions
                        dismiss()
                    }) {
                        Text("Apply Filters")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .frame(height: 36)
                            .foregroundColor(.white)
                    }
                    .listRowBackground(Color.blue)
                }
            }
            .navigationTitle("Filter")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                tempOptions = filterOptions
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Reset") {
                        withAnimation {
                            tempOptions.reset()
                        }
                    }
                    .disabled(!tempOptions.isFiltered)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    FilterView(filterOptions: .constant(FilterOptions()))
}
