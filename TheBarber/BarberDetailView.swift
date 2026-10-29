//
//  BarberDetailView.swift
//  TheBarber
//
//  Created by Jaloliddin Esonboyev on 12/08/2026.
//

import SwiftUI

struct BarberDetailView: View {
    let barber: Barber
    
    @EnvironmentObject var savedManager: SavedBarbersManager
    
    @State private var selectedDate: Date = Date()
    @State private var selectedTime: String = "12:00"
    
    @Binding var selectedTab: Int
    @Binding var navPath: NavigationPath
    
    let timeSlots = ["11:15", "12:00", "12:45", "13:30", "14:15", "15:00"]
    let portfolioImages = ["portfolio2", "portfolio3", "portfolio4", "portfolio5"]
    
    private var isBarberSaved: Bool {
        savedManager.isSaved(barber)
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                HStack(spacing: 16) {
                    Image(barber.imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 70, height: 70)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    
                    VStack(alignment:.leading, spacing: 4) {
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
                .background(Color.clear)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                
                VStack(alignment: .leading, spacing: 12) {
                    Label {
                        VStack(alignment: .leading) {
                            Text("Address")
                                .font(.body)
                                .foregroundStyle(.secondary)
                            Text(barber.location)
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

                            Text("$\(barber.price) - $\(barber.price + 50)")
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
                            ForEach(portfolioImages, id: \.self) { img in
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
                    
                    DatePicker("Select date", selection: $selectedDate, displayedComponents: [.date])
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
                            ForEach(timeSlots, id: \.self) { time in
                                Button(action: {
                                    selectedTime = time
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
                            }
                        }
                    }
                }
                Button(action: {
                    navPath.append(AppRoute.review(barber, selectedDate, selectedTime))
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
        .navigationTitle(barber.name)
        .navigationBarTitleDisplayMode(.inline)
        
        
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                ShareLink(
                    item: "\(barber.name), located at \(barber.location). Book on TheBarber!",
                    subject: Text(barber.name),
                    message: Text("Check out \(barber.name) on TheBarber")
                ) {
                    Image(systemName: "square.and.arrow.up")
                }
                
                Button(action: {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                        savedManager.toggleSave(barber)
                    }
                }) {
                    Image(systemName: isBarberSaved ? "bookmark.fill" : "bookmark")
                        .foregroundColor(isBarberSaved ? .blue : .primary)
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
            rating: 4.5,
            imageName: "barber1"
        ),
        selectedTab: .constant(0),
        navPath: .constant(NavigationPath())
    )
    .environmentObject(SavedBarbersManager())
}
