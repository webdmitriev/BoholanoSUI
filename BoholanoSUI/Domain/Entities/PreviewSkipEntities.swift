//
//  PreviewSkipStruct.swift
//  BoholanoSUI
//
//  Created by Олег Дмитриев on 16.05.2025.
//

import Foundation

struct PreviewSkipEntities: Codable, Hashable, Identifiable {
    var id: Int
    let title: String
    let descr: String
    let image: String
}
