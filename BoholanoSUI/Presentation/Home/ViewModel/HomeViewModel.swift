//
//  HomeViewModel.swift
//  BoholanoSUI
//
//  Created by Олег Дмитриев on 18.05.2025.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var houses: [Houses] = []
    private var cancellables = Set<AnyCancellable>()
    private let fetchHousesUseCase: FetchHousesUseCase
    
    @Published var travel: [Travel] = []
    private var cancellablesTravel = Set<AnyCancellable>()
    private let fetchTravelUseCase: FetchTravelUseCase
    
    
    init(fetchHousesUseCase: FetchHousesUseCase, fetchTravelUseCase: FetchTravelUseCase) {
        self.fetchHousesUseCase = fetchHousesUseCase
        self.fetchTravelUseCase = fetchTravelUseCase
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
    
    func getTravel() {
        fetchTravelUseCase.execute()
            .receive(on: DispatchQueue.main)
            .sink { complition in
                switch complition {
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                default:
                    break
                }
            } receiveValue: { [weak self] travel in
                self?.travel = travel
            }
            .store(in: &cancellablesTravel)
    }
    
}
