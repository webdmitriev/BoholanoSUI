//
//  FetchPreviewSkipRepositoryImpl.swift
//  BoholanoSUI
//
//  Created by Олег Дмитриев on 16.05.2025.
//

import Foundation
import Combine

class FetchPreviewSkipRepositoryImpl: FetchPreviewSkipRepository {
    
    private let dataSourse: FetchPreviewSkipDataSourse
    init(dataSourse: FetchPreviewSkipDataSourse) {
        self.dataSourse = dataSourse
    }
    
    func fetchPreviewSkip() -> AnyPublisher<[PreviewSkipEntities], any Error> {
        self.dataSourse.getPreviewSkipData()
    }

}
