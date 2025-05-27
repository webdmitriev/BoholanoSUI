//
//  MapView.swift
//  BoholanoSUI
//
//  Created by Олег Дмитриев on 26.05.2025.
//


import SwiftUI

struct MapView: View {
    @StateObject private var viewModel = MapViewModel()
    let houses: [Houses]
    
    var body: some View {
        UIKitMapView(
            userLocation: viewModel.userLocation,
            houses: viewModel.houses,
            route: viewModel.route
        ) { tappedHouse in
            viewModel.buildRoute(to: tappedHouse.coordinate)
        }
        .onAppear {
            viewModel.setHouses(houses)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

