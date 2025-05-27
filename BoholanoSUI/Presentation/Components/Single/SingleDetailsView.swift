//
//  SingleDetailsView.swift
//  BoholanoSUI
//
//  Created by Олег Дмитриев on 20.05.2025.
//

import SwiftUI

struct SingleDetailsView: View {
    
    var title: String = ""
    var details: HouseDetails
    
    var body: some View {
        VStack(spacing: 12) {
            Text(title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 24, weight: .bold))
                .foregroundStyle(.appBlack)
            
            HStack {
                SingleDetailsItemView(image: "detail-icon-01", label: details.apartment)
                SingleDetailsItemView(image: "detail-icon-02", label: details.rooms)
                SingleDetailsItemView(image: "detail-icon-03", label: details.bathroom)
                SingleDetailsItemView(image: "detail-icon-04", label: details.square + " sqrl")
            }
        }
        .padding(.horizontal, 16)
    }
}
