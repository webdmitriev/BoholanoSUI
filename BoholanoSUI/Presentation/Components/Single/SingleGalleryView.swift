//
//  SingleGalleryView.swift
//  BoholanoSUI
//
//  Created by Олег Дмитриев on 20.05.2025.
//

import SwiftUI

struct SingleGalleryView: View {
    
    var title: String = ""
    var gallery: [HousesGallery] = []
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(.appBlack)
                
                Spacer()
                
                NavigationLink(destination: SingleGalleryDetailView(gallery: gallery)) {
                    Text("See all")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(.appGreen)
                }
            }
            .padding(.horizontal, 16)
            
            Spacer(minLength: 16)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 8) {
                    ForEach(gallery, id: \.self) { img in
                        NetworkImage(url: img.url)
                            .frame(width: 140, height: 100)
                            .scaledToFill()
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                }
                .padding(.horizontal, 16)
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.viewAligned)
        }
    }
}
