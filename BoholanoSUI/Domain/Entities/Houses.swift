//
//  Houses.swift
//  BoholanoSUI
//
//  Created by Олег Дмитриев on 18.05.2025.
//

import Foundation
import CoreLocation

struct Houses: Codable, Hashable, Identifiable {
    var id: Int
    var title: String
    var address: String
    var descr: String
    var price: String
    var rating: String
    var image: String
    var gallery: [HousesGallery]
    var details: HouseDetails
    var facilities: [HouseFacilities]
    var recommend: Bool
    
    var longitude: Double
    var latitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    var reviews: [Review]
}

struct HousesGallery: Codable, Hashable, Identifiable {
    var id: Int
    var url: String
}

struct HouseDetails: Codable, Hashable {
    var apartment: String
    var rooms: String
    var bathroom: String
    var square: String
}

struct HouseFacilities: Codable, Hashable {
    var label: String
    var value: String
}

struct Review: Identifiable, Codable, Hashable {
    var id: String
    var name: String
    var date: String
    var rating: String
    var descr: String
}

