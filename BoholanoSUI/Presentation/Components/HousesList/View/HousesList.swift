//
//  HousesList.swift
//  BoholanoSUI
//
//  Created by Олег Дмитриев on 18.05.2025.
//

import SwiftUI

struct HousesList: View {
    
    @State var isActiveHeader: Bool = true
    var houses: [Houses]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            if isActiveHeader {
                HeaderTop(title: "Recently Booked", btnText: "See all") {
                    HousesCatalog(houses: houses)
                }
            }
            
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(spacing: 16) {
                    ForEach(houses.prefix(6), id: \.self) { home in
                        NavigationLink(destination: SingleHouseView(house: home)) {
                            HousesItem(house: home)
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 28)
            }
        }
    }
}


