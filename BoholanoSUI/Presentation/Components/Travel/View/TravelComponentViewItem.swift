//
//  TravelComponentViewItem.swift
//  BoholanoSUI
//
//  Created by Олег Дмитриев on 19.05.2025.
//

import SwiftUI

struct TravelComponentViewItem: View {
    var item: Travel
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {

            NetworkImage(url: item.image)
                .scaledToFill()
                .frame(width: 320, height: 200)
                .clipped()
            

            BgGradient(height: 140)
                
            Text(item.title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.appWhite)
                .lineLimit(2)

        }
        .frame(width: 320, height: 200)
        .background(.appWhite)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}
