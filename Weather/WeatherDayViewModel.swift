//
//  WeatherDayViewModel.swift
//  Weather
//
//  Created by Adrian Ortiz on 8/14/18.
//  Copyright © 2018 Adrian Ortiz. All rights reserved.
//

import Foundation

struct WeatherDayViewModel {
    
    let model: WeatherDay
    
    // MARK: - Properties
    private let dateFormatter = DateFormatter()
    
    var image: String {
        return model.icon
    }
    
    var temperature: String {
        return "\(Int(model.temperatureMin))˚ / \(Int(model.temperatureMax))˚"
    }
    
    func getDayFor(index: Int) -> String {
        let seconds_in_a_day = 86400
        let date = Date(timeInterval: TimeInterval((index + 1) * seconds_in_a_day), since: Date())
        dateFormatter.dateFormat = "EEE"
        return dateFormatter.string(from: date)
    }
    
}
