//
//  BarberDetailView.swift
//  TheBarber
//
//  Created by Jaloliddin Esonboyev on 12/08/2026.
//

import SwiftUI

struct BarberDetailView: View {
    @StateObject private var viewModel: BarberDetailViewModel
    
    @EnvironmentObject var savedManager: SavedBarbersManager
    
    @Binding var selectedTab: Int
    @Binding var navPath: NavigationPath
    
    init(barber: Barber, selectedTab: Binding<Int>, navPath: Binding<NavigationPath>) {
        _viewModel = StateObject(wrappedValue: BarberDetailViewModel(barber: barber))
        self._selectedTab = selectedTab
        self._navPath = navPath
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                HStack(spacing: 16) {
                    Image(viewModel.barber.imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 70, height: 70)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    
                    VStack(alignment:.leading, spacing: 4) {
                        Text(viewModel.barber.name)
                            .font(.title2)
                            .bold()
                        
                        HStack(spacing: 4) {
                            Image(systemName: "phone.fill")
                                .font(.body)
                                .foregroundColor(.secondary)
                            Text("+48 756-321-983")
                                .font(.body)
                                .foregroundColor(.secondary)
                        }
                    }
                    Spacer()
                }
                .background(Color.clear)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                
                VStack(alignment: .leading, spacing: 12) {
                    Label {
                        VStack(alignment: .leading) {
                            Text("Address")
                                .font(.body)
                                .foregroundStyle(.secondary)
                            Text(viewModel.barber.location)
                                .font(.body)
                                .bold()
                        }
                    } icon: {
                        Image(systemName: "mappin.circle.fill")
                            .foregroundStyle(.blue)
                    }
                    
                    Divider()
                    
                    Label {
                        VStack(alignment: .leading) {
                            Text("Price range")
                                .font(.body)
                                .foregroundStyle(.secondary)

                            Text("$\(viewModel.barber.price) - $\(viewModel.barber.price + 50)")
                                .font(.body)
                                .bold()
                        }
                    } icon: {
                        Image(systemName: "dollarsign.circle.fill")
                            .foregroundColor(.blue)
                    }
                    Divider()
                }
                .background(Color.clear)
                
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Work examples")
                        .font(.title2)
                        .bold()

                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(viewModel.portfolioImages, id: \.self) { img in
                                Image(img)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 140, height: 100)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                            }
                        }
                        .padding(.horizontal, 16)
                    }
                    .padding(.horizontal, -16)
                }
                
                Divider()
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Select date")
                        .font(.title2)
                        .bold()
                    
                    DatePicker("Select date", selection: $viewModel.selectedDate, displayedComponents: [.date])
                        .datePickerStyle(.graphical)
                        .background(Color(.secondarySystemGroupedBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                }
                
                Divider()
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Select time")
                        .font(.title2)
                        .bold()
                        .padding(.vertical)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(viewModel.timeSlots, id: \.self) { time in
                                Button(action: {
                                    viewModel.selectTime(time)
                                }) {
                                    Text(time)
                                        .font(.subheadline)
                                        .bold()
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 10)
                                        .background(viewModel.selectedTime == time ? Color.blue : Color(.tertiarySystemGroupedBackground))
                                        .foregroundColor(viewModel.selectedTime == time ? .white : .primary)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                }
                            }
                        }
                    }
                }
                Button(action: {
                    navPath.append(viewModel.makeReviewRoute())
                }) {
                    Text("Book appointment")
                        .font(.headline)
                        .bold()
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 52)
                        .background(Color.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                }
                .padding(.top, 8)
            }
            .padding()
        }
        .navigationTitle(viewModel.barber.name)
        .navigationBarTitleDisplayMode(.inline)
        
        
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                ShareLink(
                    item: viewModel.shareItemText,
                    subject: Text(viewModel.barber.name),
                    message: Text(viewModel.shareMessageText)
                ) {
                    Image(systemName: "square.and.arrow.up")
                }
                
                Button(action: {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                        viewModel.toggleSave(in: savedManager)
                    }
                }) {
                    Image(systemName: viewModel.isSaved(in: savedManager) ? "bookmark.fill" : "bookmark")
                        .foregroundColor(viewModel.isSaved(in: savedManager) ? .blue : .primary)
                        .contentTransition(.symbolEffect(.replace))
                }
            }
        }
    }
}

#Preview {
    BarberDetailView(
        barber: Barber(
            name: "James Barber",
            location: "Charlie street, 67th",
            price: 120,
            distance: "7 km",
            rating: 4.5,
            imageName: "barber1"
        ),
        selectedTab: .constant(0),
        navPath: .constant(NavigationPath())
    )
    .environmentObject(SavedBarbersManager())
}
