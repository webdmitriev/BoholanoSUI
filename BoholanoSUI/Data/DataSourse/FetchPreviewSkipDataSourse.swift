//
//  FetchPreviewSkipDataSourse.swift
//  BoholanoSUI
//
//  Created by Олег Дмитриев on 16.05.2025.
//

import Foundation
import Combine

protocol FetchPreviewSkipDataSourse {
    func getPreviewSkipData() -> AnyPublisher<[PreviewSkipEntities], Error>
}
