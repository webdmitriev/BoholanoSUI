//
//  FetchHousesDataSource.swift
//  BoholanoSUI
//
//  Created by Олег Дмитриев on 18.05.2025.
//

import Foundation
import Combine

protocol FetchHousesDataSource {
    func getHouses() -> AnyPublisher<[Houses], Error>
}
