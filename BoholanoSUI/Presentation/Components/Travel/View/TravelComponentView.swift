//
//  TravelComponentView.swift
//  BoholanoSUI
//
//  Created by Олег Дмитриев on 19.05.2025.
//

import SwiftUI

struct TravelComponentView: View {

    var travel: [Travel] = []
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HeaderTop(title: "Recently Booked", btnText: "See all") {
                TravelCatalog()
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 12) {
                    ForEach(travel) { item in
                        NavigationLink(destination: SingleTravelView(travel: item)) {
                            TravelComponentViewItem(item: item)
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
