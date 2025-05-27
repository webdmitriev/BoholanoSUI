//
//  UIKitMapView.swift
//  BoholanoSUI
//
//  Created by Олег Дмитриев on 26.05.2025.
//

import SwiftUI
import MapKit

struct UIKitMapView: UIViewRepresentable {
    var userLocation: CLLocationCoordinate2D?
    var houses: [Houses]
    var route: MKRoute?
    var onHouseTapped: (House) -> Void

    func makeCoordinator() -> Coordinator {
        Coordinator(onHouseTapped: onHouseTapped)
    }

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.showsUserLocation = true
        mapView.pointOfInterestFilter = .excludingAll
        return mapView
    }

    func updateUIView(_ mapView: MKMapView, context: Context) {
        mapView.removeAnnotations(mapView.annotations)
        mapView.removeOverlays(mapView.overlays)
        
        // Добавление аннотаций домов
        for house in houses {
            let annotation = MKPointAnnotation()
            annotation.title = house.title
            annotation.coordinate = house.coordinate
            mapView.addAnnotation(annotation)
        }

        // Добавление маршрута
        if let route = route {
            mapView.addOverlay(route.polyline)
            mapView.setVisibleMapRect(route.polyline.boundingMapRect,
                                      edgePadding: UIEdgeInsets(top: 60, left: 40, bottom: 60, right: 40),
                                      animated: true)
        } else if let userLocation = userLocation {
            let region = MKCoordinateRegion(center: userLocation,
                                            span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
            mapView.setRegion(region, animated: true)
        }
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var onHouseTapped: (House) -> Void

        init(onHouseTapped: @escaping (House) -> Void) {
            self.onHouseTapped = onHouseTapped
        }

        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            if let polyline = overlay as? MKPolyline {
                let renderer = MKPolylineRenderer(polyline: polyline)
                renderer.strokeColor = .blue
                renderer.lineWidth = 5
                return renderer
            }
            return MKOverlayRenderer()
        }

        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            guard
                let annotation = view.annotation,
                let title = annotation.title ?? "",
                let _ = mapView.annotations
                    .compactMap({ $0 as? MKPointAnnotation })
                    .first(where: { $0.title == title })
            else { return }

            let tappedHouse = House(title: title, coordinate: annotation.coordinate)
            onHouseTapped(tappedHouse)
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            guard !(annotation is MKUserLocation) else { return nil }

            let identifier = "CustomHouseAnnotation"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

            if annotationView == nil {
                annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView?.canShowCallout = false // мы сами покажем подпись

                // ✅ Настраиваем кастомную иконку (SVG из Assets)
                let image = UIImage(named: "location-marker")?
                    .resized(to: CGSize(width: 48, height: 48)) // чуть крупнее

                let imageView = UIImageView(image: image)
                imageView.translatesAutoresizingMaskIntoConstraints = false

                // ✅ Подпись под иконкой
                let label = UILabel()
                label.text = annotation.title ?? ""
                label.font = .systemFont(ofSize: 12, weight: .medium)
                label.textAlignment = .center
                label.numberOfLines = 2
                label.textColor = .black
                label.translatesAutoresizingMaskIntoConstraints = false

                // ✅ Контейнер
                let stack = UIStackView(arrangedSubviews: [imageView, label])
                stack.axis = .vertical
                stack.alignment = .center
                stack.spacing = 2
                stack.translatesAutoresizingMaskIntoConstraints = false

                let container = UIView()
                container.addSubview(stack)

                NSLayoutConstraint.activate([
                    stack.centerXAnchor.constraint(equalTo: container.centerXAnchor),
                    stack.centerYAnchor.constraint(equalTo: container.centerYAnchor)
                ])

                annotationView?.addSubview(container)
                container.translatesAutoresizingMaskIntoConstraints = false

                NSLayoutConstraint.activate([
                    container.centerXAnchor.constraint(equalTo: annotationView!.centerXAnchor),
                    container.centerYAnchor.constraint(equalTo: annotationView!.centerYAnchor)
                ])
            } else {
                annotationView?.annotation = annotation
            }

            return annotationView
        }

    }
}

