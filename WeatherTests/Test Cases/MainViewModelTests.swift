//
//  MainViewModelTests.swift
//  WeatherTests
//
//  Created by Adrian Ortiz on 8/14/18.
//  Copyright © 2018 Adrian Ortiz. All rights reserved.
//

import XCTest
@testable import Weather

class MainViewModelTests: XCTestCase {
    
    var viewModel: MainViewModel!
    
    override func setUp() {
        super.setUp()
        
        let data = loadStubFromBundle(withName: "darksky", extension: "json")
        let weatherData: WeatherModel = try! JSONDecoder().decode(WeatherModel.self, from: data)
        
        viewModel = MainViewModel(repository: WeatherRepository(), model: weatherData)

    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSummary() {
        XCTAssertEqual(viewModel.summary, "Asia/Bishkek \n Clear")
    }
    
    func testTemperature() {
        XCTAssertEqual(viewModel.temperature, "44˚")
    }
    
    func testIconTemp() {
        XCTAssertEqual(viewModel.iconTemp, "clear-day")
    }
    
    func testMinTemp() {
        XCTAssertEqual(viewModel.minTemp, "Min: 36˚")
    }
    
    func testMaxTemp() {
        XCTAssertEqual(viewModel.maxTemp, "Max: 47˚")
    }
    
    func testNumberOfItemsInSection() {
        XCTAssertEqual(viewModel.numberOfItemsInSection, 7)
    }
    
}
