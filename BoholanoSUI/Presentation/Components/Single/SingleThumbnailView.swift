//
//  SingleThumbnailView.swift
//  BoholanoSUI
//
//  Created by Олег Дмитриев on 22.05.2025.
//

import SwiftUI
import CoreLocation

struct SingleThumbnailView: View {
    
    var latitude: Double
    var longitude: Double

    @State private var showMap = false
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var showPicker: Bool = false
    
    var thumbnail: String
    
    var house: Houses
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            GeometryReader { geo in
                let minY = geo.frame(in: .global).minY
                
                NetworkImage(url: thumbnail)
                    .scaledToFill()
                    .frame(height: 380 + (minY > 0 ? minY : 0))
                    .frame(width: geo.size.width)
                    .clipped()
                    .offset(y: -minY)
            
                BgGradient(height: (140 + (minY > 0 ? minY : 0)), reverse: false)
                    .offset(y: -minY)
                
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
                    
                    NavigationLink {
                        MapView(houses: [house])
                    } label: {
                        Image(systemName: "map")
                            .resizable()
                            .frame(width: 28, height: 28)
                            .foregroundStyle(.appWhite)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.top, 80)
                .padding(.horizontal, 16)
            }
            .frame(height: 356)
        }
    }
}
