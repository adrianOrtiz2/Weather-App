//
//  WeatherModel.swift
//  Weather
//
//  Created by Adrian Ortiz on 8/14/18.
//  Copyright © 2018 Adrian Ortiz. All rights reserved.
//

import Foundation

struct WeatherCurrently: Decodable {
    let summary: String
    let icon: String
    let temperature: Double
}

struct WeatherDaily: Decodable {
    let summary: String
    let data: [WeatherDay]
}

struct WeatherModel: Decodable {
    
    let timezone: String
    let currently: WeatherCurrently
    let daily: WeatherDaily
}
