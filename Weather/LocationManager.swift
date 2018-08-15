//
//  LocationManager.swift
//  Weather
//
//  Created by Adrian Ortiz on 8/15/18.
//  Copyright © 2018 Adrian Ortiz. All rights reserved.
//

import Foundation
import CoreLocation

class LocationManager: NSObject {
    
    // MARK: - Properties
    private lazy var locationManager: CLLocationManager = {
        // Initialize Location Manager
        let locationManager = CLLocationManager()
        
        // Configure Location Manager
        locationManager.distanceFilter = 1000.0
        locationManager.desiredAccuracy = 1000.0
        
        return locationManager
    }()
    
    typealias LocationResponse = ((CLLocation) -> ())
    let locationResponse: LocationResponse
    
    // MARK: - Init
    init(locationResponse: @escaping LocationResponse) {
        self.locationResponse = locationResponse
    }
    
    // MARK: - Functions
    func requestLocation() {
        locationManager.delegate = self
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            locationManager.requestLocation()
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
}

extension LocationManager: CLLocationManagerDelegate {
    
    // MARK: - Location Change Authorization
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            manager.requestLocation()
        } else {
            locationResponse(Defaults.location)
        }
    }
    
    // MARK: - Location Updates
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            locationResponse(location)
            manager.delegate = nil
            manager.stopUpdatingHeading()
        } else { // Failed to get location
            locationResponse(Defaults.location)
        }
    }
    
    // MARK: - Location Did Fail
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationResponse(Defaults.location)
    }
    
}
