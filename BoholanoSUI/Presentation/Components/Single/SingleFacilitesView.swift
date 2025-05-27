//
//  SingleFacilitesView.swift
//  BoholanoSUI
//
//  Created by Олег Дмитриев on 20.05.2025.
//

import SwiftUI

struct SingleFacilitesView: View {

    var title: String = ""
    var facilities: [HouseFacilities] = []
    
    var body: some View {
        VStack(spacing: 12) {
            Text(title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 24, weight: .bold))
                .foregroundStyle(.appBlack)
            
            let columns = [
                GridItem(.adaptive(minimum: 86), spacing: 8)
            ]
            
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(facilities, id: \.self) { facility in
                    SingleDetailsItemView(image: facility.value, label: facility.label)
                }
            }
        }
        .padding(.horizontal, 16)
    }
}
