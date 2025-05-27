//
//  SingleHeaderView.swift
//  BoholanoSUI
//
//  Created by Олег Дмитриев on 22.05.2025.
//

import SwiftUI

struct SingleHeaderView: View {
    
    var house: Houses
    
    var body: some View {
        VStack {
            Text(house.title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16)
                .font(.system(size: 28, weight: .bold))
                .foregroundStyle(.appBlack)
            
            Spacer(minLength: 16)
            
            NavigationLink {
                MapView(houses: [house])
            } label: {
                HStack(alignment: .top, spacing: 12) {
                    Image(systemName: "map")
                        .resizable()
                        .frame(width: 18, height: 18)
                        .foregroundStyle(.appGreen)
                    
                    Text(house.address)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(.appBlack.opacity(0.7))
                }
                    .padding(.horizontal, 16)
            }
            .buttonStyle(.plain)
            
            Spacer(minLength: 36)
            
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.appBlack.opacity(0.2))
                .padding(.horizontal, 16)
            
            Spacer(minLength: 28)
        }
    }
}
