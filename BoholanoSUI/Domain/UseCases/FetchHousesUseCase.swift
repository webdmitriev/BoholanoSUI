//
//  FetchHousesUseCase.swift
//  BoholanoSUI
//
//  Created by Олег Дмитриев on 18.05.2025.
//

import Foundation
import Combine

protocol FetchHousesUseCase {
    func execute() -> AnyPublisher<[Houses], Error>
}

class FetchHousesUseCaseImpl: FetchHousesUseCase {
    
    let repository: FetchHousesRepository
    init(repository: FetchHousesRepository) {
        self.repository = repository
    }
    
    func execute() -> AnyPublisher<[Houses], Error> {
        self.repository.fetchHouses()
    }
}
