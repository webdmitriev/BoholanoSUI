//
//  SingleGalleryDetailView.swift
//  BoholanoSUI
//
//  Created by Олег Дмитриев on 22.05.2025.
//

import SwiftUI

struct SingleGalleryDetailView: View {
    
    var gallery: [HousesGallery] = []
    let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]
    let columnWidth = (UIScreen.main.bounds.width - 36) / 2
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(gallery, id: \.self) { img in
                    NetworkImage(url: img.url)
                        .frame(width: columnWidth, height: 150)
                        .scaledToFill()
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
            }
            .padding(.horizontal, 16)
        }
        .navigationTitle(Text("Gallery"))
    }
}
