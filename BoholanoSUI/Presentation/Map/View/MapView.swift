//
//  MapView.swift
//  BoholanoSUI
//
//  Created by Олег Дмитриев on 26.05.2025.
//


import SwiftUI

struct MapView: View {
    @Environment(\.dismiss) var dismiss
    
    @StateObject private var viewModel = MapViewModel()
    let houses: [Houses]
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            UIKitMapView(
                userLocation: viewModel.userLocation,
                houses: viewModel.houses,
                route: viewModel.route
            ) { tappedHouse in
                viewModel.buildRoute(to: tappedHouse.coordinate)
            }
            
            HStack {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "arrowshape.backward")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundStyle(.white)
                }
                
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 80)
            .padding(.horizontal, 16)
        }
        .onAppear {
            viewModel.setHouses(houses)
        }
        .navigationBarBackButtonHidden(true)
        .edgesIgnoringSafeArea(.all)
    }
}

