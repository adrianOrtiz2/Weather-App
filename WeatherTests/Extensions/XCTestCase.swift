//
//  XCTestCase.swift
//  WeatherTests
//
//  Created by Adrian Ortiz on 8/14/18.
//  Copyright © 2018 Adrian Ortiz. All rights reserved.
//

import XCTest

extension XCTestCase {
    
    func loadStubFromBundle(withName name: String, extension: String) -> Data {
        let bundle = Bundle(for: classForCoder)
        let url = bundle.url(forResource: name, withExtension: `extension`)
        return try! Data(contentsOf: url!)
    }
    
}
