//
//  LocationPicker.swift
//  BoholanoSUI
//
//  Created by Олег Дмитриев on 23.05.2025.
//

import SwiftUI
import CoreLocation
import MapKit

extension View {
    func locationPicker(
        isPresented: Binding<Bool>,
        initialCoordinates: CLLocationCoordinate2D?,
        coordinates: @escaping (CLLocationCoordinate2D?) -> ()
    ) -> some View {
        self.fullScreenCover(isPresented: isPresented) {
            LocationPickerView(
                isPresented: isPresented,
                initialCoordinates: initialCoordinates,
                coordinates: coordinates
            )
        }
    }
}

fileprivate struct LocationPickerView: View {
    @Binding var isPresented: Bool
    var initialCoordinates: CLLocationCoordinate2D?
    var coordinates: (CLLocationCoordinate2D?) -> ()
    
    @StateObject private var manager = LocationManager()
    @State private var selectedCoordinate: CLLocationCoordinate2D?
    
    @State private var route: MKRoute?
    @State private var showRoute = false
    
    @State private var hasCenteredOnHouse = false
    
    @Namespace private var mapSpace
    @Environment(\.openURL) private var openURL
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            if let isPermissionDenied = manager.isPermissinDenied {
                if isPermissionDenied {
                    NoPermissionView()
                } else {
                    MapView()
                }
            } else {
                Text("Loading View")
            }
        }
        .onAppear {
            if let initialCoordinates {
                selectedCoordinate = initialCoordinates
                // Центрируем карту на доме с анимацией
                centerMapOnHouse(coordinates: initialCoordinates)
            }
        }
    }
    
    private func centerMapOnHouse(coordinates: CLLocationCoordinate2D) {
        guard !hasCenteredOnHouse else { return }
        hasCenteredOnHouse = true
        
        let region = MKCoordinateRegion(
            center: coordinates,
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        )
        
        withAnimation(.easeInOut(duration: 1.0)) {
            manager.position = .region(region)
        }
    }
    
    @ViewBuilder
    func NoPermissionView() -> some View {
        ZStack(alignment: .bottom) {
            Rectangle()
                .fill(.ultraThinMaterial)
                .ignoresSafeArea()
            
            Text("Please allow location permission \nin the app settings!")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
            
            Button {
                isPresented = false
            } label: {
                Image(systemName: "xmark")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                    .padding(15)
                    .contentShape(.rect)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            
            VStack(spacing: 12) {
                Button("Try Again", action: manager.requestUserLocation)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                
                Button {
                    if let settingURL = URL(string: UIApplication.openSettingsURLString) {
                        openURL(settingURL)
                    }
                } label: {
                    Text("Go to Settings")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .foregroundStyle(.appWhite)
                        .background(Color.primary, in: .rect(cornerRadius: 12))
                }
                .padding(.horizontal, 30)
                .padding(.bottom, 10)
            }

        }
    }
    
    @ViewBuilder
    func MapView() -> some View {
        Map(position: $manager.position, interactionModes: .all) {
            // Показываем маркер текущего местоположения
            UserAnnotation()
            
            // Показываем маркер выбранного дома
            if let selectedCoordinate {
                Annotation("House for rent", coordinate: selectedCoordinate) {
                    Image(systemName: "house.fill")
                        .foregroundColor(.white)
                        .padding(8)
                        .background(Color.blue)
                        .clipShape(Circle())
                        .onTapGesture {
                            calculateRoute(to: selectedCoordinate)
                        }
                }
            }
            
            if let route, showRoute {
                MapPolyline(route)
                    .stroke(.blue, lineWidth: 5)
            }
        }
        .overlay(alignment: .topTrailing) {
            Button("Back") {
                isPresented = false
            }
            .padding()
        }
        .overlay(alignment: .bottomLeading) {
            if route != nil {
                Button(action: { showRoute.toggle() }) {
                    Image(systemName: showRoute ? "eye.slash" : "eye")
                        .padding()
                        .background(.regularMaterial)
                        .clipShape(Circle())
                }
                .padding()
            }
        }
    }
    
    private func calculateRoute(to destination: CLLocationCoordinate2D) {
        manager.calculateRoute(to: destination) { newRoute in
            route = newRoute
            showRoute = true
            
            if let route {
                let padding = 50.0
                let rect = route.polyline.boundingMapRect
                manager.position = .rect(rect.insetBy(dx: -padding, dy: -padding))
            }
        }
    }
}

fileprivate class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var isPermissinDenied: Bool?
    
    @Published var currentRegion: MKCoordinateRegion?
    @Published var position: MapCameraPosition = .automatic
    @Published var userCoordinates: CLLocationCoordinate2D?
    
    private var manager: CLLocationManager = .init()
    
    override init() {
        super.init()
        manager.delegate = self
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = manager.authorizationStatus
        
        guard status != .notDetermined else { return }
        
        isPermissinDenied = status == .denied
        if status != .denied {
            manager.startUpdatingLocation()
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coordinates = locations.first?.coordinate else { return }
        
        userCoordinates = coordinates
        let region = MKCoordinateRegion(center: coordinates, latitudinalMeters: 10000, longitudinalMeters: 10000)
        position = .region(region)
        
        manager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        
    }
    
    func requestUserLocation() {
        manager.requestWhenInUseAuthorization()
    }
    
    func calculateRoute(to destination: CLLocationCoordinate2D, completion: @escaping (MKRoute?) -> Void) {
        guard let userLocation = userCoordinates else {
            completion(nil)
            return
        }
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: userLocation))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destination))
        request.transportType = .automobile
        
        let directions = MKDirections(request: request)
        directions.calculate { response, error in
            if let route = response?.routes.first {
                completion(route)
            } else {
                print("Route error: \(error?.localizedDescription ?? "Unknown error")")
                completion(nil)
            }
        }
    }
    
}
