//
//  HeaderTop.swift
//  BoholanoSUI
//
//  Created by Олег Дмитриев on 17.06.2025.
//

import SwiftUI

struct HeaderTop<Destination: View>: View {
    
    let title: String
    let btnText: String
    let destination: () -> Destination
    
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 20, weight: .bold))
                .foregroundStyle(.appBlack)
            
            Spacer()
            
            if btnText.count > 0 {
                NavigationLink(destination: destination, label: {
                    Text(btnText)
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.appGreen)
                })
            }
        }
        .padding(.horizontal, 16)
    }
}
