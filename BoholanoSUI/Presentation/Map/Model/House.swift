//
//  House.swift
//  BoholanoSUI
//
//  Created by Олег Дмитриев on 26.05.2025.
//


import Foundation
import CoreLocation

struct House: Identifiable {
    let id = UUID()
    let title: String
    let coordinate: CLLocationCoordinate2D
    
    static func Mock() -> [House] {
        [
            House(title: "Дом 1", coordinate: CLLocationCoordinate2D(latitude: 9.6295, longitude: 123.8262)),
            House(title: "Дом 2", coordinate: CLLocationCoordinate2D(latitude: 9.6349, longitude: 123.8781)),
            House(title: "Дом 3", coordinate: CLLocationCoordinate2D(latitude: 9.6588, longitude: 123.8672))
        ]
    }
}

