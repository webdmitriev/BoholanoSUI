//
//  MapViewModel.swift
//  BoholanoSUI
//
//  Created by Олег Дмитриев on 26.05.2025.
//


import Foundation
import MapKit
import Combine

class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var userLocation: CLLocationCoordinate2D?
    @Published var houses: [Houses] = []
    @Published var route: MKRoute?
    
    private let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func setHouses(_ newHouses: [Houses]) {
        houses = newHouses
    }
    
    func buildRoute(to destination: CLLocationCoordinate2D) {
        guard let userLocation = userLocation else { return }

        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: userLocation))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destination))
        request.transportType = .automobile

        MKDirections(request: request).calculate { [weak self] response, error in
            if let route = response?.routes.first {
                DispatchQueue.main.async {
                    self?.route = route
                }
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        userLocation = location.coordinate
    }
}
