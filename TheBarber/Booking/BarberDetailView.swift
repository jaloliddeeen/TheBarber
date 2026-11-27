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
                
                BarberDetailHeaderView(barber: viewModel.barber)
                
                BarberInfoSection(location: viewModel.barber.location, price: viewModel.barber.price)
                
                PortfolioCarouselView(images: viewModel.portfolioImages)
                
                Divider()
                
                DatePickerSection(selectedDate: $viewModel.selectedDate)
                
                Divider()
                
                TimeSlotPickerView(
                    timeSlots: viewModel.timeSlots,
                    selectedTime: viewModel.selectedTime,
                    onSelectTime: viewModel.selectTime
                )
                
                PrimaryButton(title: "Book meeting") {
                    navPath.append(viewModel.makeReviewRoute())
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


struct BarberDetailHeaderView: View {
    let barber: Barber
    
    var body: some View {
        HStack(spacing: 16) {
            Image(barber.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 70, height: 70)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            
            VStack(alignment: .leading, spacing: 4) {
                Text(barber.name)
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
    }
}


struct BarberInfoSection: View {
    let location: String
    let price: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            DetailInfoRow(
                title: "Address",
                subtitle: location,
                iconName: "mappin.circle.fill"
            )
            
            Divider()
            
            DetailInfoRow(
                title: "Price range",
                subtitle: "$\(price) - $\(price + 50)",
                iconName: "dollarsign.circle.fill"
            )
            
            Divider()
        }
    }
}


struct DetailInfoRow: View {
    let title: String
    let subtitle: String
    let iconName: String
    
    var body: some View {
        Label {
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.body)
                    .foregroundStyle(.secondary)
                Text(subtitle)
                    .font(.body)
                    .bold()
            }
        } icon: {
            Image(systemName: iconName)
                .foregroundStyle(.blue)
        }
    }
}


struct PortfolioCarouselView: View {
    let images: [String]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Work examples")
                .font(.title2)
                .bold()
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(images, id: \.self) { img in
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
    }
}


struct DatePickerSection: View {
    @Binding var selectedDate: Date
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Select date")
                .font(.title2)
                .bold()
            
            DatePicker("Select date", selection: $selectedDate, displayedComponents: [.date])
                .datePickerStyle(.graphical)
                .background(Color(.secondarySystemGroupedBackground))
                .clipShape(RoundedRectangle(cornerRadius: 16))
        }
    }
}


struct TimeSlotPickerView: View {
    let timeSlots: [String]
    let selectedTime: String
    let onSelectTime: (String) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Select time")
                .font(.title2)
                .bold()
                .padding(.vertical, 4)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(timeSlots, id: \.self) { time in
                        Button(action: {
                            onSelectTime(time)
                        }) {
                            Text(time)
                                .font(.subheadline)
                                .bold()
                                .padding(.horizontal, 16)
                                .padding(.vertical, 10)
                                .background(selectedTime == time ? Color.blue : Color(.tertiarySystemGroupedBackground))
                                .foregroundColor(selectedTime == time ? .white : .primary)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                        .buttonStyle(.plain)
                    }
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
