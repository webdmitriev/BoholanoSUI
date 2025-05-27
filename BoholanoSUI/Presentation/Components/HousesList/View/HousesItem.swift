//
//  HousesItem.swift
//  BoholanoSUI
//
//  Created by Олег Дмитриев on 19.05.2025.
//

import SwiftUI

struct HousesItem: View {
    
    var house: Houses
    
    var body: some View {
        HStack(spacing: 18) {
            NetworkImage(url: house.image)
                .frame(width: 100, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 16))
            

            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 4) {
                    Text(house.title)
                        .font(.system(size: 18, weight: .bold))
                        .foregroundStyle(.appBlack)
                    
                    Spacer()
                    
                    HStack(spacing: 12) {
                        Image(systemName: "star")
                            .frame(width: 14, height: 14)
                            .foregroundStyle(.appGreen)
                        
                        Text(house.rating)
                            .font(.system(size: 17, weight: .medium))
                            .foregroundStyle(.appBlack.opacity(0.8))
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .lineLimit(1)
                
                Text(house.address)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 14, weight: .regular))
                    .lineLimit(1)
                    .foregroundStyle(.appBlack.opacity(0.8))
                
                HStack(alignment: .firstTextBaseline, spacing: 4) {
                    Text("$\(house.price)")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundStyle(.appGreen)
                    
                    Text("/ per day")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(.appBlack.opacity(0.8))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .lineLimit(1)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(12)
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(Color.white)
                .shadow(
                    color: .black.opacity(0.1),
                    radius: 10,
                    x: 0,
                    y: 2
                )
        )
    }
}
