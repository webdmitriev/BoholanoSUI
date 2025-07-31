//
//  SingleGalleryDetailView.swift
//  BoholanoSUI
//
//  Created by Олег Дмитриев on 22.05.2025.
//

import SwiftUI

struct SingleGalleryDetailView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    var gallery: [HousesGallery] = []
    let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]
    let columnWidth = (UIScreen.main.bounds.width - 36) / 2
    
    var body: some View {
        ZStack(alignment: .topLeading) {
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
            .padding(.top, 50)
            
            HStack {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "arrowshape.backward")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundStyle(.appBlack)
                }
                
                Spacer()
                
                Text("Gallery")
                    .multilineTextAlignment(.center)
                    .font(.system(size: 24, weight: .bold, design: .default))
                    .foregroundStyle(.appBlack)
                
                Spacer()
                
                Circle()
                    .frame(width: 24, height: 24)
                    .foregroundStyle(.clear)
                    .background(.clear)
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 5)
            .padding(.horizontal, 16)
        }
        .navigationBarBackButtonHidden(true)
    }
}
