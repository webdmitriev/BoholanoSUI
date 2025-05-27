//
//  RecommendedHousesView.swift
//  BoholanoSUI
//
//  Created by Олег Дмитриев on 27.05.2025.
//

import SwiftUI

struct RecommendedHousesView: View {
    
    var houses: [Houses]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(houses) { house in
                    NavigationLink(destination: SingleHouseView(house: house)) {
                        CategoryGroupItemView(house: house)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 16)
            .scrollTargetLayout()
        }
        .scrollTargetBehavior(.viewAligned)
    }
}
