//
//  SearchViewModel.swift
//  BoholanoSUI
//
//  Created by Олег Дмитриев on 19.05.2025.
//

import Foundation
import Combine

class SearchViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var searchIsActieve: Bool = false
    @Published var filteredHouses: [Houses] = []
    
    private var allHouses: [Houses] = []
    private var cancellables = Set<AnyCancellable>()
    
    init(houses: [Houses]) {
        self.allHouses = houses

        $searchText
            .debounce(for: .seconds(2), scheduler: RunLoop.main)
            .removeDuplicates()
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .sink { [weak self] text in
                self?.searchIsActieve = !text.isEmpty
                self?.filterHouses(with: text.lowercased())
            }
            .store(in: &cancellables)
        
        self.filteredHouses = houses
    }
    
    private func filterHouses(with query: String) {
        filteredHouses = allHouses.filter {
            $0.title.lowercased().contains(query) ||
            $0.address.lowercased().contains(query)
        }
    }
}
