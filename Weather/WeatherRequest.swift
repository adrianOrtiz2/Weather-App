//
//  WeatherRequest.swift
//  Weather
//
//  Created by Adrian Ortiz on 8/14/18.
//  Copyright © 2018 Adrian Ortiz. All rights reserved.
//

import Foundation
import CoreLocation

struct WeatherRequest {
    
    let baseURL: String
    let location: CLLocation
    
    // MARK: - Location Properties
    var latitude: Double {
        return location.coordinate.latitude
    }
    
    var longitude: Double {
        return location.coordinate.longitude
    }
    
    // MARK: - Weather Request URL
    var url: String {
        return "\(baseURL)\(latitude),\(longitude)"
    }
    
}
