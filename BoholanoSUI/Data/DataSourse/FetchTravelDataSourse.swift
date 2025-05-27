//
//  FetchTravelDataSourse.swift
//  BoholanoSUI
//
//  Created by Олег Дмитриев on 19.05.2025.
//

import Foundation
import Combine

protocol FetchTravelDataSourse {
    func getTravelData() -> AnyPublisher<[Travel], Error>
}
