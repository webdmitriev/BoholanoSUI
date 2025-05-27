//
//  RemoteHousesDataSourseImpl.swift
//  BoholanoSUI
//
//  Created by Олег Дмитриев on 18.05.2025.
//

import Foundation
import Combine

class RemoteHousesDataSourseImpl: FetchHousesDataSource {
    
    func getHouses() -> AnyPublisher<[Houses], any Error> {
        let urlString = "https://api.webdmitriev.com/wp-json/wp/v2/bohol-houses/"
        
        guard let url = URL(string: urlString) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        let dataPublisher = URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [Houses].self, decoder: JSONDecoder())
            .map { $0 }
            .eraseToAnyPublisher()

        return dataPublisher
    }
}

