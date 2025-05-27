//
//  HousesList.swift
//  BoholanoSUI
//
//  Created by Олег Дмитриев on 18.05.2025.
//

import SwiftUI

struct HousesList: View {
    
    private let title: String = "Recently Booked"
    
    var house: [Houses]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(title)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(.appBlack)
                
                Spacer()
                
                Button("See All") {
                    print("Catalog screen")
                }
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.appGreen)
            }
            .padding(.horizontal, 16)
            
            
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(spacing: 16) {
                    ForEach(house, id: \.self) { home in
                        NavigationLink(destination: SingleHouseView(house: home)) {
                            HousesItem(image: home.image, title: home.title, address: home.address, price: home.price, rating: home.rating)
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 28)
            }
        }
    }
}


