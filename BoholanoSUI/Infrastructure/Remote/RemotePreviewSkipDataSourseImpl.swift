//
//  RemotePreviewSkipDataSourseImpl.swift
//  BoholanoSUI
//
//  Created by Олег Дмитриев on 16.05.2025.
//

import Foundation
import Combine

class RemotePreviewSkipDataSourseImpl: FetchPreviewSkipDataSourse {

    func getPreviewSkipData() -> AnyPublisher<[PreviewSkipEntities], Error> {
        let urlString = "https://api.webdmitriev.com/wp-json/wp/v2/bohol/"
        
        guard let url = URL(string: urlString) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        let dataPublisher = URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [PreviewSkipEntities].self, decoder: JSONDecoder())
            .map { $0 }
            .eraseToAnyPublisher()
        
        return dataPublisher
            
    }

}
