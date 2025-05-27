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
