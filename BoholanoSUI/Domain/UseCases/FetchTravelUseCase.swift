//
//  FetchTravelUseCase.swift
//  BoholanoSUI
//
//  Created by Олег Дмитриев on 19.05.2025.
//

import Foundation
import Combine

protocol FetchTravelUseCase {
    func execute() -> AnyPublisher<[Travel], Error>
}

class FetchTravelUseCaseImpl: FetchTravelUseCase {
    
    let repository: FetchTravelRepository
    init(repository: FetchTravelRepository) {
        self.repository = repository
    }

    func execute() -> AnyPublisher<[Travel], any Error> {
        self.repository.getTravels()
    }
    
    
}
