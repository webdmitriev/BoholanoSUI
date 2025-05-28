//
//  FilterSheetView.swift
//  BoholanoSUI
//
//  Created by Олег Дмитриев on 18.05.2025.
//

import SwiftUI

struct FilterSheetView: View {
    
    //@Environment(\.dismiss) private var dismiss
    
    let houses: [Houses]
    @StateObject private var viewModel: PriceFilterViewModel
    
    init(houses: [Houses]) {
        self.houses = houses
        let maxPrice = houses.map { Double($0.price) }.max() ?? 0
        _viewModel = StateObject(wrappedValue: PriceFilterViewModel(min: 0, max: maxPrice))
    }
    
    var body: some View {
        ScrollView {
            VStack {
                RoundedRectangle(cornerRadius: 3)
                    .fill(Color.gray.opacity(0.4))
                    .frame(width: 40, height: 5)
                    .padding(.top, 8)
                
                Text("Filter Hotel")
                    .padding(.top, 8)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(.appBlack)
            }
            .padding(.top, 16)
            .padding(.horizontal, 16)
            
            Spacer(minLength: 16)
            
            Divider()
            
            Spacer(minLength: 16)
            
            FilterSheetHeaderView(title: "Place", filterPlaces: ["Panglao", "Bohol", "Anda", "Calape", "Chocolate hills"])
            
            Spacer(minLength: 16)
            
            Divider()
            
            Spacer(minLength: 16)
            
            Text("Price")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16)
                .font(.system(size: 20, weight: .bold))
                .foregroundStyle(.appBlack)

            Spacer(minLength: 32)
            
            CustomRangeSlider(
                lowerValue: $viewModel.filter.selectedMin,
                upperValue: $viewModel.filter.selectedMax,
                range: viewModel.filter.minPrice...viewModel.filter.maxPrice,
                step: 1
            )
            .frame(height: 40)
            
            Spacer(minLength: 16)
            
            Divider()
            
            Spacer(minLength: 16)
            
            FilterSheetHeaderView(title: "Star rating", filterPlaces: ["10", "9", "8", "7", "6", "5", "4", "3", "2", "1"])
            
            Spacer(minLength: 16)
            
            Divider()
            
            Spacer(minLength: 16)
            
            FilterSheetHeaderView(title: "Facilities", filterPlaces: ["Swimming pool", "WiFi", "Restaurant", "Parking", "Meeting Room", "Elevator", "Fitness Center", "24-hours Open"])
            
            Spacer(minLength: 16)
            
            Divider()
            
            Spacer(minLength: 16)
            
            Button(action: {
                print("Selected range: \(viewModel.filter.selectedMin) – \(viewModel.filter.selectedMax)")
            }) {
                Text("Apply Filter")
                    .padding(.vertical, 10)
                    .padding(.horizontal, 32)
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.appWhite)
            }
            .background(.appGreen)
            .clipShape(RoundedRectangle(cornerRadius: 24))
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .cornerRadius(16)
    }
}


struct FilterSheetHeaderView: View {
    
    let title: String
    let filterPlaces: [String]
    @State private var selectedPlaces: Set<String> = []
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(.appBlack)
                
                Spacer()
                
                if !selectedPlaces.isEmpty {
                    Text("(\(selectedPlaces.count))")
                        .foregroundColor(.appGreen)
                }

                if !selectedPlaces.isEmpty {
                    Button("Reset") {
                        selectedPlaces.removeAll()
                    }
                    .font(.subheadline)
                    .foregroundColor(.red)
                    .padding(.trailing, 16)
                }
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(filterPlaces, id: \.self) { item in
                        FilterSheetHeaderItemView(
                            txt: item,
                            isActive: selectedPlaces.contains(item),
                            onTap: {
                                togglePlaceSelection(item)
                            }
                        )
                    }
                }
                .padding(.horizontal, 16)
            }
            
        }
    }
    
    private func togglePlaceSelection(_ place: String) {
        if selectedPlaces.contains(place) {
            selectedPlaces.remove(place)
        } else {
            selectedPlaces.insert(place)
        }
    }
}

struct FilterSheetHeaderItemView: View {
    
    var txt: String = ""
    var isActive: Bool = false
    var onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            Text(txt)
                .padding(.vertical, 8)
                .padding(.horizontal, 22)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(isActive ? .appWhite : .appGreen)
                .overlay {
                    RoundedRectangle(cornerRadius: 24)
                        .stroke(.appGreen, lineWidth: 2)
                }
        }
        .background(isActive ? .appGreen : .appWhite)
        .clipShape(RoundedRectangle(cornerRadius: 24))
    }
}
