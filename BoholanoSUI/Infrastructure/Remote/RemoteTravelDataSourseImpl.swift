//
//  RemoteTravelDataSourseImpl.swift
//  BoholanoSUI
//
//  Created by Олег Дмитриев on 19.05.2025.
//

import Foundation
import Combine

class RemoteTravelDataSourseImpl: FetchTravelDataSourse {
        
    func getTravelData() -> AnyPublisher<[Travel], Error> {
        let urlString = "https://api.webdmitriev.com/wp-json/wp/v2/bohol-travel/"
        
        guard let url = URL(string: urlString) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        let dataPublisher = URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [Travel].self, decoder: JSONDecoder())
            .map { $0 }
            .eraseToAnyPublisher()

        return dataPublisher
    }
    
}
