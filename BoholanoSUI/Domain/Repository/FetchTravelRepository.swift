//
//  FetchTravelRepository.swift
//  BoholanoSUI
//
//  Created by Олег Дмитриев on 19.05.2025.
//

import Foundation
import Combine

protocol FetchTravelRepository {
    func getTravels() -> AnyPublisher<[Travel], Error>
}
