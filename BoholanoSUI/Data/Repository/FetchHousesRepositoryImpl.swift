//
//  FetchHousesRepositoryImpl.swift
//  BoholanoSUI
//
//  Created by Олег Дмитриев on 18.05.2025.
//

import Foundation
import Combine

class FetchHousesRepositoryImpl: FetchHousesRepository {

    private let dataSource: FetchHousesDataSource
    init(dataSource: FetchHousesDataSource) {
        self.dataSource = dataSource
    }
    
    func fetchHouses() -> AnyPublisher<[Houses], any Error> {
        self.dataSource.getHouses()
    }
    
    
}
