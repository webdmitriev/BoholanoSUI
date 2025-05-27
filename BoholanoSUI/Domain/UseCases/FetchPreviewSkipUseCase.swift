//
//  FetchPreviewSkipUseCase.swift
//  BoholanoSUI
//
//  Created by Олег Дмитриев on 16.05.2025.
//

import Foundation
import Combine

protocol FetchPreviewSkipUseCase {
    func execute() -> AnyPublisher<[PreviewSkipEntities], Error>
}

final class FetchPreviewSkipUseCaseImpl: FetchPreviewSkipUseCase {
        
    let repository: FetchPreviewSkipRepository
    init(repository: FetchPreviewSkipRepository) {
        self.repository = repository
    }
    
    func execute() -> AnyPublisher<[PreviewSkipEntities], any Error> {
        self.repository.fetchPreviewSkip()
    }
}
