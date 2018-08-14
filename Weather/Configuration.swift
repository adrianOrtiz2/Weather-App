//
//  Configuration.swift
//  Weather
//
//  Created by Adrian Ortiz on 8/14/18.
//  Copyright © 2018 Adrian Ortiz. All rights reserved.
//

import Foundation
import CoreLocation

enum Defaults {
    
    static let location = CLLocation(latitude: 37.335114, longitude: -122.008928)
    
}

enum WeatherService {
    
    private static let apiKey = "5b72a3036aee39ed2836e931ee286bd9/"
    private static let url = "https://api.darksky.net/forecast/"
    
    static var baseUrl: String {
        return "\(url)\(apiKey)"
    }
    
}
