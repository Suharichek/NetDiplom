//
//  LocationViewController.swift
//  Navigation
//
//  Created by Suharik on 03.10.2022.
//

import UIKit
import SnapKit
import MapKit
import CoreLocation

class LocationViewController: UIViewController {
    
    //MARK: Properties
    
    private lazy var mapView: MKMapView = {
        let map = MKMapView()
        map.mapType = .standard
        map.showsUserLocation = true
        map.showsScale = true
        map.showsCompass = true
        map.showsTraffic = true
        map.showsBuildings = true
        map.showsLargeContentViewer = true
        return map
    }()
    
    private lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        return manager
    }()
    
    private lazy var routeButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.backgroundColor = .buttonColor
        button.layer.cornerRadius = 10
        button.setTitle("routeButtonTitle".localized, for: .normal)
        button.setTitleColor(.textColor, for: .normal)
        button.setTitleColor(UIColor.lightGray, for: .highlighted)
        button.addTarget(self, action: #selector(routeButtonPressed), for: .touchUpInside)
        button.isEnabled = false
        button.isUserInteractionEnabled = false
        button.alpha = 0
        return button
    }()
    
    private lazy var removeButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.backgroundColor = .buttonColor
        button.layer.cornerRadius = 10
        button.setTitle("removeButtonTitle".localized, for: .normal)
        button.setTitleColor(.textColor, for: .normal)
        button.setTitleColor(UIColor.lightGray, for: .highlighted)
        button.addTarget(self, action: #selector(removeButtonPressed), for: .touchUpInside)
        button.isEnabled = false
        button.isUserInteractionEnabled = false
        button.alpha = 0
        return button
    }()
    
    //MARK: Main Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "locationTitle".localized
        view.backgroundColor = .backgroundColor
        locationManager.delegate = self
        mapView.delegate = self
        view.addSubview(mapView)
        view.addSubview(routeButton)
        view.addSubview(removeButton)
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestAlwaysAuthorization()
            locationManager.requestLocation()
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        case .restricted, .denied:
            break
        @unknown default:
            break
        }
        setupLayout()
    }
    
    func setupLayout() {
        mapView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.trailing.equalTo(view.snp.trailing)
            make.leading.equalTo(view.snp.leading)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        routeButton.snp.makeConstraints { make in
            make.trailing.equalTo(mapView.snp.trailing).offset(-8)
            make.bottom.equalTo(mapView.snp.bottom).offset(-30)
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
        
        removeButton.snp.makeConstraints { make in
            make.leading.equalTo(mapView.snp.leading).offset(8)
            make.bottom.equalTo(mapView.snp.bottom).offset(-30)
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
        
    }
    
    //MARK: Added Functions
    
    func route (from startLocation: CLLocationCoordinate2D, to endLocation: CLLocationCoordinate2D) {
        
        mapView.removeOverlays(mapView.overlays)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        
        let sourceRegion = MKCoordinateRegion(center: startLocation, span: span)
        let destinationRegion = MKCoordinateRegion(center: endLocation, span: span)
        
        mapView.setRegion(sourceRegion, animated: true)
        mapView.setRegion(destinationRegion, animated: true)
        
        let startPlacemark = MKPlacemark(coordinate: startLocation, addressDictionary: nil)
        let endPlacemark = MKPlacemark(coordinate: endLocation, addressDictionary: nil)
        
        let directionRequest = MKDirections.Request()
        directionRequest.source = MKMapItem(placemark: startPlacemark)
        directionRequest.destination = MKMapItem(placemark: endPlacemark)
        directionRequest.transportType = .walking
        
        let directions = MKDirections(request: directionRequest)
        
        directions.calculate { response, error in
            guard let response = response else {
                if let error = error {
                    print ("📍 ОШИБКА МАРШРУТА: \(error.localizedDescription)")
                }
                return
            }
            
            let route = response.routes[0]
            self.mapView.addOverlay(route.polyline, level: .aboveRoads)
            
            let rect = route.polyline.boundingMapRect
            self.mapView.setRegion( MKCoordinateRegion(rect), animated: true)
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else { return }
        mapView.removeAnnotations(mapView.annotations)
        
        let convertedCoor = mapView.convert((touch.location(in: mapView)), toCoordinateFrom: mapView)
        
        let pin = MKPointAnnotation()
        pin.coordinate = convertedCoor
        pin.title = "pinTitle".localized
        mapView.addAnnotation(pin)

        routeButton.isEnabled = true
        routeButton.isUserInteractionEnabled = true
        routeButton.alpha = 1
        removeButton.isEnabled = true
        removeButton.isUserInteractionEnabled = true
        removeButton.alpha = 1
    }
    
    @objc private func routeButtonPressed() {
        let startPoint = mapView.userLocation
        let startCoord = startPoint.coordinate
        let endPoint = mapView.annotations.last
        
        guard let endCoord = endPoint?.coordinate else { return }
        route(from: startCoord, to: endCoord)
        buttonsEnabled()
    }
    
    @objc private func removeButtonPressed() {
        let allAnnotations = self.mapView.annotations
        mapView.removeAnnotations(allAnnotations)
        let overLays = mapView.overlays
        mapView.removeOverlays(overLays)
        let userLocation = mapView.userLocation
        mapView.setCenter(userLocation.coordinate, animated: true)
        buttonsEnabled()
    }
    
    private func buttonsEnabled() {
        routeButton.isEnabled = routeButton.isEnabled == false ? true : false
        routeButton.isUserInteractionEnabled = routeButton.isUserInteractionEnabled == false ? true : false
        routeButton.alpha = routeButton.alpha == 0 ? 1 : 0
        removeButton.isEnabled = removeButton.isEnabled == false ? true : false
        removeButton.isUserInteractionEnabled = removeButton.isUserInteractionEnabled == false ? true : false
        removeButton.alpha = removeButton.alpha == 0 ? 1 : 0
    }
    
}

    //MARK: Extensions

extension LocationViewController: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedAlways {
            manager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let region = MKCoordinateRegion(center: locations.first!.coordinate, span: .init(latitudeDelta: 0.015, longitudeDelta: 0.015))
        mapView.setCenter(locations.first!.coordinate, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.mapView.setRegion(region, animated: true)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("⛔️ \(error.localizedDescription)")
    }
    
}

extension LocationViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = .orange
        renderer.lineWidth = 2.0
        return renderer
    }
}
