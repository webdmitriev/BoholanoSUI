//
//  TravelCatalog.swift
//  BoholanoSUI
//
//  Created by Олег Дмитриев on 17.06.2025.
//

import SwiftUI

struct TravelCatalog: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State var travel: [Travel] = []
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            VStack(spacing: 24) {
                if !travel.isEmpty {
                    ScrollView(.vertical, showsIndicators: false) {
                        LazyVStack(spacing: 12) {
                            ForEach(travel) { item in
                                NavigationLink(destination: SingleTravelView(travel: item)) {
                                    ZStack(alignment: .bottomLeading) {

                                        NetworkImage(url: item.image)
                                            .scaledToFill()
                                            .frame(maxWidth: .infinity)
                                            .frame(height: 200)
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
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 200)
                                    .background(.appWhite)
                                    .clipShape(RoundedRectangle(cornerRadius: 16))
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.horizontal, 16)
                        .scrollTargetLayout()
                    }
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
                
                Text("Travel list")
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
