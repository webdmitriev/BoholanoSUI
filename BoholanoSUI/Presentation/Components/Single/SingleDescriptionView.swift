//
//  SingleDescriptionView.swift
//  BoholanoSUI
//
//  Created by Олег Дмитриев on 20.05.2025.
//

import SwiftUI

struct SingleDescriptionView: View {

    var title: String = ""
    var descr: String = ""
    
    @State private var isExpanded = false
    private let lineLimit = 5
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.system(size: 24, weight: .bold))
                .foregroundStyle(.appBlack)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(descr.convertHTMLBreaksToNewlines())
                    .font(.system(size: 16))
                    .foregroundStyle(.appBlack.opacity(0.8))
                    .lineLimit(isExpanded ? nil : lineLimit)
                    .lineSpacing(1.2)
                    .overlay(alignment: .bottomTrailing) {
                        if !isExpanded {
                            Button(action: { isExpanded.toggle() }) {
                                Text("Read More...")
                                    .padding(.leading, 8)
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(.appGreen)
                                    .background(.appWhite)
                            }
                            .offset(y: 1) // Корректировка позиции
                        }
                    }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 16)
    }
}
