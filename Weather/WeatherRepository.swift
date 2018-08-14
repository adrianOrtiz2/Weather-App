//
//  WeatherRepository.swift
//  Weather
//
//  Created by Adrian Ortiz on 8/14/18.
//  Copyright © 2018 Adrian Ortiz. All rights reserved.
//

import Foundation
import Alamofire

class WeatherRepository {
    
    // MARK: - Properties
    typealias WeatherResponse = ((_ response: WeatherModel?, _ error: String?) -> ())
    
    func fetchWeatherData(request: WeatherRequest, weatherResponse: @escaping WeatherResponse) {
        Alamofire.request(request.url, method: .get)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { (response) in
                switch response.result {
                    case .success:
                        let weather = try! JSONDecoder().decode(WeatherModel.self, from: response.data!)
                        weatherResponse(weather, nil)
                    case .failure(let error):
                        weatherResponse(nil, error.localizedDescription)
                }
        }
    }
    
}

