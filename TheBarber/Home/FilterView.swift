//
//  FilterView.swift
//  TheBarber
//
//  Created by Jaloliddin Esonboyev on 12/08/2026.
//

import SwiftUI

struct FilterView: View {
    @Environment(\.dismiss) private var dismiss
        
    @StateObject private var viewModel: FilterViewModel
    
    init(filterOptions: Binding<FilterOptions>) {
        _viewModel = StateObject(wrappedValue: FilterViewModel(
            initialOptions: filterOptions.wrappedValue,
            onApply: { newOptions in
                filterOptions.wrappedValue = newOptions
            }
        ))
    }
    
    var body: some View {
        NavigationStack{
            Form {
                Section("Sort by") {
                    Picker("Sort by", selection: $viewModel.draftOptions.sortBy) {
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
                            Text("$\(Int(viewModel.draftOptions.maxPrice))")
                                .font(.headline)
                                .foregroundColor(.blue)
                        }
                        Slider(value: $viewModel.draftOptions.maxPrice, in: 50...150, step: 5)
                    }
                    .padding(.vertical, 4)
                }
                
                Section("Minimum rating") {
                    Picker("Rating", selection: $viewModel.draftOptions.minRating) {
                        ForEach(viewModel.ratingOptions, id: \.value) { option in
                            Text(option.label).tag(option.value)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section {
                    Button(action: {
                        viewModel.apply()
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
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Reset") {
                        withAnimation {
                            viewModel.reset()
                        }
                    }
                    .disabled(!viewModel.canReset)
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
