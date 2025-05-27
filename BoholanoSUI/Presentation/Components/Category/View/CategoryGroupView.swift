//
//  CategoryGroupView.swift
//  BoholanoSUI
//
//  Created by Олег Дмитриев on 18.05.2025.
//

import SwiftUI

struct CategoryGroupView: View {
    
    var title: String
    var houses: [Houses] = []

    var body: some View {
        VStack {
            if !title.isEmpty {
                HStack {
                    Text(title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundStyle(.appBlack)
                    
                    Spacer()
                    
                    Button("See All") {
                        print("CategoryGroupView")
                    }
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.appGreen)
                }
                .padding(.horizontal, 16)
                
                Spacer(minLength: 16)
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(houses.prefix(6), id: \.self) { house in
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
}
