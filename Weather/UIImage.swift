//
//  UIImage.swift
//  Weather
//
//  Created by Adrian Ortiz on 8/14/18.
//  Copyright © 2018 Adrian Ortiz. All rights reserved.
//

import UIKit

extension UIImage {
    
    class func imageForIcon(withName name:String) -> UIImage? {
        switch name {
            case "clear-day" : return UIImage(named: "sunny")
            case "rain", "snow", "cloudy": return UIImage(named: name)
            case "sleet": return UIImage(named: "snow")
            case "wind","partly-cloudy-day", "partly-cloudy-night", "clear-night": return UIImage(named: "cloudy")
            default: return UIImage(named: "sunny")
        }
    }
    
}
