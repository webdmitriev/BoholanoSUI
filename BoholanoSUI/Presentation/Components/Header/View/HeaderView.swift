//
//  HeaderView.swift
//  BoholanoSUI
//
//  Created by Олег Дмитриев on 17.05.2025.
//

import SwiftUI

struct HeaderView: View {
    
    private let wavingHandEmojis = ["👋🏻", "🖐️", "🤚", "🤟", "✌🏻"]

    private let headerLogoImage: String = "boholano-logotype-01"
    private let headerLogoText: String = "Bohol"
    private let headerFavorite: String = "header-favorite"
    
    private var headerNaming: String {
        "Hello, Oleg \(wavingHandEmojis.randomElement() ?? "👋")"
    }
    
    var body: some View {
        VStack {
            HStack {
                HStack(spacing: 12) {
                    Image(headerLogoImage)
                        .resizable()
                        .frame(width: 38, height: 38)
                        .scaledToFit()
                    
                    Text(headerLogoText)
                        .font(.system(size: 24, weight: .bold))
                        .foregroundStyle(.appBlack)
                }
                
                Spacer()
                
                HStack(spacing: 12) {
                    Button(action: {}) {
                        Image("header-favorite")
                            .resizable()
                            .frame(width: 32, height: 32)
                            .scaledToFit()
                    }
                }
            }
            
            Spacer(minLength: 24)
            
            Text(headerNaming)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 32, weight: .bold))
                .foregroundStyle(.appBlack)
        }
        .padding(.top, 16)
        .padding(.horizontal, 16)
    }
}
