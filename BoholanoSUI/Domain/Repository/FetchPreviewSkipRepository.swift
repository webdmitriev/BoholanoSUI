//
//  FetchPreviewSkipRepository.swift
//  BoholanoSUI
//
//  Created by Олег Дмитриев on 16.05.2025.
//

import Foundation
import Combine

protocol FetchPreviewSkipRepository {
    func fetchPreviewSkip() -> AnyPublisher<[PreviewSkipEntities], Error>
}
