//
//  BarberCardView.swift
//  TheBarber
//
//  Created by Jaloliddin Esonboyev on 12/08/2026.
//

import SwiftUI

struct Barber: Identifiable, Hashable {
    
    let id = UUID()
    let name: String
    let location: String
    let price: Int
    let rating: Double
    let imageName: String
}

struct BarberCardView: View {
    let barber: Barber
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ZStack(alignment: .topTrailing) {
                Image(barber.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 130)
                    .frame(maxWidth: .infinity)
                    .background(Color(.systemGray5))
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                
                HStack(spacing: 3) {
                    Image(systemName: "star.fill")
                        .font(.caption2)
                        .foregroundStyle(.yellow)
                    Text(String(format: "%.1f", barber.rating))
                        .font(.caption)
                        .bold()
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(.black.opacity(0.65))
                .clipShape(Capsule())
                .padding(8)
            }
            
            HStack(spacing: 4) {
                Image(systemName: "mappin.circle.fill")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text(barber.location)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            Text(barber.name)
                .font(.headline)
                .lineLimit(1)
            
            Text("$\(barber.price)")
                .font(.subheadline)
                .bold()
                .foregroundColor(.blue)
            
            Text("Book now")
                .font(.subheadline)
                .bold()
                .frame(maxWidth: .infinity)
                .padding(.vertical, 8)
                .background(Color.blue.opacity(0.12))
                .foregroundColor(.blue)
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        }
        .padding(10)
        .background(Color(.secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(color: .black.opacity(0.04), radius: 6, x: 0, y: 3)
    }
}

#Preview {
    BarberCardView(
        barber: Barber(
            name: "James Barber",
            location: "Charlie street, 67th",
            price: 120,
            rating: 4.5,
            imageName: "barber1"
        )
    )
    .padding()
}
