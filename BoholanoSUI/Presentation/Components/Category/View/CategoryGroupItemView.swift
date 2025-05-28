//
//  CategoryGroupItemView.swift
//  BoholanoSUI
//
//  Created by Олег Дмитриев on 27.05.2025.
//

import SwiftUI

struct CategoryGroupItemView: View {
    
    var house: Houses
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            
            NetworkImage(url: house.image)
                .frame(width: 218, height: 308)
                .clipped()
            
            BgGradient(height: 160)
                .frame(height: 160)
                .frame(maxWidth: .infinity, alignment: .bottom)
            
            VStack(spacing: 8) {
                
                // Rating badge
                HStack {
                    Spacer()
                    HStack(spacing: 6) {
                        Image(systemName: "star.fill")
                            .resizable()
                            .frame(width: 14, height: 14)
                            .foregroundColor(.white)
                        
                        Text(house.rating)
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(Color.appGreen.opacity(0.8))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 6) {
                    Text(house.title)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                        .lineLimit(2)
                        .truncationMode(.tail)
                    
                    Text(house.address)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.white.opacity(0.7))
                        .lineLimit(1)
                        .truncationMode(.tail)
                    
                    HStack(alignment: .firstTextBaseline, spacing: 4) {
                        Text("$\(Int(house.price))")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white)
                        
                        Text("/ per day")
                            .font(.system(size: 13, weight: .medium))
                            .foregroundColor(.white.opacity(0.8))
                    }
                }
            }
            .padding(16)
        }
        .frame(width: 218, height: 308)
        .background(Color.gray.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .shadow(radius: 1)
    }
}
