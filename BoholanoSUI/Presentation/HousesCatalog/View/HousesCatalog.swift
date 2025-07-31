//
//  HousesCatalog.swift
//  BoholanoSUI
//
//  Created by Олег Дмитриев on 17.06.2025.
//

import SwiftUI

struct HousesCatalog: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State var houses: [Houses] = []
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            VStack(spacing: 24) {
                SearchComponentView(houses: houses)
                
                if !houses.isEmpty {
                    HousesList(isActiveHeader: false, houses: houses)
                }
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
                
                Text("Catalog")
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
