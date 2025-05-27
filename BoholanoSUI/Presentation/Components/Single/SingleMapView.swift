//
//  SingleMapView.swift
//  BoholanoSUI
//
//  Created by Олег Дмитриев on 20.05.2025.
//

import SwiftUI

struct SingleMapView: View {
    
    var title: String = ""

    var latitude: Double
    var longitude: Double


    var body: some View {
        VStack(spacing: 12) {
            Text(title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 24, weight: .bold))
                .foregroundStyle(.appBlack)
            
            NavigationLink(destination: SingleMapDetailView(latitude: latitude, longitude: longitude)) {
                ZStack {
                    Image("boholano-map")
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity, maxHeight: 220)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .opacity(0.8)
                    
                    Image(systemName: "mappin.and.ellipse")
                        .resizable()
                        .frame(width: 42, height: 42)
                        .scaledToFit()
                        .foregroundStyle(.appGreen)
                }
            }

        }
        .padding(.horizontal, 16)
    }
}

