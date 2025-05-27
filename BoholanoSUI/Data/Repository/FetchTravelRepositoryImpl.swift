//
//  FetchTravelRepositoryImpl.swift
//  BoholanoSUI
//
//  Created by Олег Дмитриев on 19.05.2025.
//

import Foundation
import Combine

class FetchTravelRepositoryImpl: FetchTravelRepository {
    
    let dataSourse: FetchTravelDataSourse
    init(dataSourse: FetchTravelDataSourse) {
        self.dataSourse = dataSourse
    }
    
    func getTravels() -> AnyPublisher<[Travel], any Error> {
        self.dataSourse.getTravelData()
    }
}
