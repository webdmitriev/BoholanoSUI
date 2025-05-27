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
            // Кастомный header
            HStack(spacing: 12) {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.black)
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

            Spacer(minLength: 24)
            
            VStack {
                if viewModel.searchText.isEmpty {
                    Text("Recommended:")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 24, weight: .bold))
                        .foregroundStyle(.appBlack)
                    
                } else {
                    if viewModel.searchIsActieve {
                        ForEach(viewModel.filteredHouses) { home in
                            HousesItem(image: home.image, title: home.title, address: home.address, price: home.price, rating: home.rating)
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
            .padding(.horizontal, 16)

        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}
