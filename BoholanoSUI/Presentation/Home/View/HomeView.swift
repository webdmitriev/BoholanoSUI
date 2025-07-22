//
//  HomeView.swift
//  BoholanoSUI
//
//  Created by Олег Дмитриев on 16.05.2025.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel: HomeViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                if viewModel.travel.isEmpty {
                    VStack {
                        ProgressView("Boholano...")
                            .progressViewStyle(CircularProgressViewStyle(tint: .appGreen))
                            .foregroundColor(.appGreen)
                            .padding()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.white)
                } else {
                    ScrollView {
                        HeaderView()
                        
                        Spacer(minLength: 24)
                        
                        SearchComponentView(houses: viewModel.houses)
                        
                        Spacer(minLength: 24)
                        
//                        CategoryView()
                        
                        Spacer(minLength: 16)
                        
                        TravelComponentView(travel: viewModel.travel)
                        
                        Spacer(minLength: 36)
                        
                        if !viewModel.houses.isEmpty {
                            HousesList(house: viewModel.houses)
                        }
                        
                        if !viewModel.recommendedHouses.isEmpty {
                            CategoryGroupView(title: "Recommended", houses: viewModel.recommendedHouses)
                        }
                    }
                    .background(Color.appBg)
                }
            }
            .onAppear {
                viewModel.getHouses()
                viewModel.getTravel()
            }
        }
    }
}


//App
//- Helpers
//Data
//- DataSource
//- Repository
//Domain
//- Entities
//- Repository
//- Usecase
//Infrastructure
//- InMemory
//- Remote
//Presentation
//- Onboarding
//-- View
//-- ViewModel
//- Home
//-- View
//-- ViewModel
//- Photo
//-- View
//-- ViewModel
//- Library
//-- View
//-- ViewModel
//- Setting
