//
//  FilterView.swift
//  TheBarber
//
//  Created by Jaloliddin Esonboyev on 12/08/2026.
//

import SwiftUI

struct FilterView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var maxPrice: Double = 150
    @State private var selectedDistance: String = "Any"
    @State private var selectedRating: String = "All"
    
    let distanceOptions = ["Any", "1-3 km", "3-7 km", "7-12 km"]
    let ratingOptions = ["All", "3.0+", "4.0+", "5.0"]
    
    var body: some View {
        NavigationStack{
            Form{
                Section(header: Text("Filter by price")) {
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text("Max price:")
                            Spacer()
                            Text("$\(Int(maxPrice))")
                                .bold()
                                .foregroundColor(.blue)
                        }
                        Slider(value: $maxPrice, in: 30...200, step: 5)
                    }
                    .padding(.vertical, 4)
                }
                Section(header: Text("Distance")) {
                    Picker("Distance", selection: $selectedDistance) {
                        ForEach(distanceOptions, id: \.self) { option in
                            Text(option).tag(option)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section(header: Text("Rating")) {
                    Picker("Rating", selection: $selectedRating) {
                        ForEach(ratingOptions, id: \.self) { option in
                            Text(option).tag(option)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section {
                    Button(action: {
                        dismiss()
                    }) {
                        HStack {
                            Spacer()
                            Text("Apply filters")
                                .font(.headline)
                                .bold()
                            Spacer()
                        }
                    }
                }
            }
            .navigationTitle("Filter")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    FilterView()
}
