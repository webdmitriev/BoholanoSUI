//
//  SingleHouseView.swift
//  BoholanoSUI
//
//  Created by Олег Дмитриев on 19.05.2025.
//

import SwiftUI

struct SingleHouseView: View {
    
    var house: Houses
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                ScrollView {
                    VStack {
                        SingleThumbnailView(house: house)
                        
                        VStack {
                            SingleHeaderView(house: house)
                            
                            SingleGalleryView(title: "Gallery Photos", gallery: house.gallery)
                            
                            Spacer(minLength: 36)
                            
                            SingleDetailsView(title: "Details", details: house.details)
                            
                            Spacer(minLength: 36)
                            
                            SingleDescriptionView(title: "Description", descr: house.descr)
                            
                            Spacer(minLength: 36)
                            
                            SingleFacilitesView(title: "Facilites", facilities: house.facilities)
                            
                            Spacer(minLength: 36)
                            
                            SingleMapView(title: "Location", house: house)
                            
                            Spacer(minLength: 36)
                            
                            SingleReviewView(title: "Reviews", reviews: house.reviews)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, 24)
                        .background(.white)
                        .clipShape(.rect(topLeadingRadius: 16, topTrailingRadius: 16))
                    }
                    .padding(.bottom, 140)
                }
                
                HStack {
                    HStack(alignment: .firstTextBaseline, spacing: 4) {
                        Text("$\(house.price)")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundStyle(.appGreen)
                        
                        Text("/ per day")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundStyle(.appBlack.opacity(0.8))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .lineLimit(1)
                    
                    Spacer()
                    
                    Button(action: {}) {
                        Text("Book now")
                            .padding(.horizontal, 42)
                            .padding(.vertical, 16)
                            .font(.system(size: 18, weight: .bold))
                            .background(.appGreen)
                            .foregroundColor(.appWhite)
                            .clipShape(RoundedRectangle(cornerRadius: 28))
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: 100)
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
                .background(Color.appWhite)
                .clipShape(.rect(topLeadingRadius: 16, topTrailingRadius: 16))
                .shadow(color: .black.opacity(0.1), radius: 5, y: -2)
                
            }
        }
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
    }
}
