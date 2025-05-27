//
//  CategoryView.swift
//  BoholanoSUI
//
//  Created by Олег Дмитриев on 17.05.2025.
//

import SwiftUI

struct CategoryView: View {
    
    // Массив категорий
    let categories = ["All", "Panglao", "Bohol", "Anda", "Chocolate hills"]
    
    // Текущая активная категория
    @State private var activeCategory: String = "All"
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(categories, id: \.self) { cat in
                    CategoryButtonView(
                        txt: cat,
                        isActive: activeCategory == cat,
                        onTap: {
                            activeCategory = cat
                        }
                    )
                }
            }
            .padding(.horizontal, 16)
        }
    }
}

struct CategoryButtonView: View {
    
    var txt: String = ""
    var isActive: Bool
    var onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            Text(txt)
                .frame(maxWidth: .infinity)
                .font(.system(size: 16, weight: .bold))
                .padding(.horizontal, 24)
                .padding(.vertical, 10)
                .foregroundStyle(isActive ? .appWhite : .appGreen)
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(.appGreen, lineWidth: 2)
                    )
        }
        .background(isActive ? .appGreen : .appWhite)
        .clipShape(RoundedRectangle(cornerRadius: 24))
        
    }
}
