//
//  SearchComponentView.swift
//  BoholanoSUI
//
//  Created by Олег Дмитриев on 17.05.2025.
//

import SwiftUI
import Combine

struct SearchComponentView: View {
    
    @State private var activeSheet: Bool = false
    
    var houses: [Houses] = []
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .scaledToFit()
                    .foregroundStyle(.appGray)
                
                NavigationLink(destination: SearchView(houses: houses)) {
                    Text("Find your apartment")
                        .padding(.horizontal, 8)
                        .padding(.vertical, 8)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundStyle(.appBlack.opacity(0.6))
                }
                
                Button(action: {
                    self.activeSheet = true
                }) {
                    Image("icon-filter")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .scaledToFit()
                }
                
            }
            .padding(.vertical, 6)
            .padding(.horizontal, 18)
            .frame(maxWidth: .infinity)
            .background(.appInput)
            .clipShape(RoundedRectangle(cornerRadius: 8))

        }
        .padding(.horizontal, 16)
        .sheet(isPresented: $activeSheet, content: {
            FilterSheetView(houses: houses)
        })
    }
}
