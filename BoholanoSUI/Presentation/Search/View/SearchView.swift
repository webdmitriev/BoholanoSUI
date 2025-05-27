//
//  SearchView.swift
//  BoholanoSUI
//
//  Created by Олег Дмитриев on 19.05.2025.
//

import SwiftUI

struct SearchView: View {
    
    @Environment(\.dismiss) private var dismiss

    @StateObject private var viewModel: SearchViewModel
    
    init(houses: [Houses]) {
        _viewModel = StateObject(wrappedValue: SearchViewModel(houses: houses))
    }
    
    var body: some View {
        ScrollView {
            HStack(spacing: 12) {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "arrowshape.backward")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundStyle(.appBlack)
                }

                TextField("Find your apartment", text: $viewModel.searchText)
                    .padding(10)
                    .background(Color(.appInput))
                    .cornerRadius(8)
                    .overlay(
                        HStack {
                            Spacer()
                            if !viewModel.searchText.isEmpty {
                                Button(action: {
                                    viewModel.searchText = ""
                                }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(.gray)
                                }
                                .padding(.trailing, 8)
                            }
                        }
                    )
                    .onChange(of: viewModel.searchText) { _, newValue in
                        viewModel.searchIsActieve = false
                    }
            }
            .padding(.horizontal)
            .padding(.top, 12)

            Spacer(minLength: 36)
            
            VStack(alignment: .leading, spacing: 12) {
                if viewModel.searchText.isEmpty {
                    Text("Recommended for vacation:")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 16)
                        .font(.system(size: 22, weight: .bold))
                        .foregroundStyle(.appBlack)
                    
                    RecommendedHousesView(houses: viewModel.recommendedHouses)
                    
                    Spacer(minLength: 24)
                    
                    Text("Recommended for travel:")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 16)
                        .font(.system(size: 22, weight: .bold))
                        .foregroundStyle(.appBlack)
                    
                    RecommendedTravelView()
                    
                } else {
                    if viewModel.searchIsActieve {
                        ForEach(viewModel.filteredHouses) { home in
                            NavigationLink(destination: SingleHouseView(house: home)) {
                                HousesItem(house: home)
                            }
                        }
                        
                        if viewModel.filteredHouses.isEmpty {
                            Text("Not found!")
                                .frame(maxWidth: .infinity, alignment: .center)
                                .font(.system(size: 24, weight: .medium))
                                .foregroundStyle(.appBlack)
                        }
                        
                    } else {
                        ProgressView()
                    }
                }
            }

        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}
