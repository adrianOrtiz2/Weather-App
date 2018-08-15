//
//  MainViewModel.swift
//  Weather
//
//  Created by Adrian Ortiz on 8/14/18.
//  Copyright (c) 2018 Adrian Ortiz. All rights reserved.
//
import Foundation
import CoreLocation

class MainViewModel {

    private var model: WeatherModel?
    typealias DidFetchWeather = ((Bool, String?) -> ())
    
    // MARK: - Properties
    private let repository: WeatherRepository
    var didFetchWeather: DidFetchWeather?
    
    init(repository: WeatherRepository) {
        self.repository = repository
        self.model = nil
    }
    
    init(repository: WeatherRepository, model: WeatherModel) {
        self.repository = repository
        self.model = model
    }
    
    var summary: String {
        guard let model = model else {
            return ""
        }
        return "\(model.timezone) \n \(model.currently.summary)"
    }
    
    var temperature: String {
        guard let model = model else {
            return "-"
        }
        return "\(Int(model.currently.temperature))˚"
    }
    
    var iconTemp: String {
        guard let model = model else {
            return ""
        }
        return model.currently.icon
    }
    
    var minTemp: String {
        guard let model = model,
            model.daily.data.count > 0 else {
            return ""
        }
        return "Min: \(Int(model.daily.data[0].temperatureMin))˚"
    }
    
    var maxTemp: String {
        guard let model = model,
            model.daily.data.count > 0 else {
                return ""
        }
        return "Max: \(Int(model.daily.data[0].temperatureMax))˚"
    }
    
    var dayTemp: String {
        guard let model = model,
            model.daily.data.count > 0 else {
                return ""
        }
        return "\(Int(model.daily.data[0].temperatureMin))˚ / \(Int(model.daily.data[0].temperatureMax))˚"
    }
    
    var numberOfItemsInSection: Int {
        guard let model = model,
            model.daily.data.count > 1 else {
                return 0
        }
        return model.daily.data.count - 1
    }
    
    // MARK: - Functions
    
    func dayViewModelFor(index i: Int) -> WeatherDayViewModel? {
        guard let model = model,
            model.daily.data.count > i + 1 else {
                return nil
        }
        return WeatherDayViewModel(model: model.daily.data[i + 1])
    }
    
    func fetchWeatherData(with location: CLLocation) {
        let weahterRequest = WeatherRequest(baseURL: WeatherService.baseUrl, location: location)
        repository.fetchWeatherData(request: weahterRequest) { (response, error) in
            self.model = response
            if let error = error {
                self.didFetchWeather?(false, error)
            } else {
                self.didFetchWeather?(true, nil)
            }
        }
    }
    
}

