//
//  HousesList.swift
//  BoholanoSUI
//
//  Created by Олег Дмитриев on 18.05.2025.
//

import SwiftUI

struct HousesList: View {
    
    @StateObject var vm: HomeViewModel
    @State var isActiveHeader: Bool = true
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            if isActiveHeader {
                HeaderTop(title: "Recently Booked", btnText: "See all") {
                    HousesCatalog(viewModel: vm)
                }
            }
            
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(spacing: 16) {
                    ForEach(vm.recommendedHouses.prefix(4), id: \.self) { home in
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


