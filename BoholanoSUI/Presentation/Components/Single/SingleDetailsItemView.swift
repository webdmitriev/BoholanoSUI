//
//  SingleDetailsItemView.swift
//  BoholanoSUI
//
//  Created by Олег Дмитриев on 20.05.2025.
//

import SwiftUI

struct SingleDetailsItemView: View {
    
    var image: String
    var label: String
    
    var body: some View {
        VStack(spacing: 12) {
            Image(image)
                .resizable()
                .frame(width: 32, height: 32)
                .scaledToFit()
            
            Text(label)
                .frame(maxWidth: .infinity, alignment: .center)
                .font(.system(size: 12, weight: .regular))
                .foregroundStyle(.appBlack)
        }
    }
}
