//
//  HousesCatalogViewModel.swift
//  BoholanoSUI
//
//  Created by Олег Дмитриев on 31.07.2025.
//

import Foundation
import Combine

final class HousesCatalogViewModel: ObservableObject {

    @Published var houses: [Houses] = []
    private var cancellables = Set<AnyCancellable>()
    private let fetchHousesUseCase: FetchHousesUseCase
    
    init(fetchHousesUseCase: FetchHousesUseCase) {
        self.fetchHousesUseCase = fetchHousesUseCase
    }
    
    func getHouses() {
        fetchHousesUseCase.execute()
            .receive(on: DispatchQueue.main)
            .sink { complition in
                switch complition {
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                default:
                    break
                }
                
            } receiveValue: { [weak self] houses in
                self?.houses = houses
                
            }
            .store(in: &cancellables)
    }
    
}
