//
//  WeatherDay.swift
//  Weather
//
//  Created by Adrian Ortiz on 8/14/18.
//  Copyright © 2018 Adrian Ortiz. All rights reserved.
//

import Foundation

struct WeatherDay: Decodable {
    
    let summary: String
    let icon: String
    let temperatureMin: Double
    let temperatureMax: Double
    
}
