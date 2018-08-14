//
//  DayWeatherCell.swift
//  Weather
//
//  Created by Adrian Ortiz on 8/14/18.
//  Copyright © 2018 Adrian Ortiz. All rights reserved.
//

import UIKit

class DayWeatherCell: UICollectionViewCell {
    
    static let ReuseIdentifier = "DayCell"
    
    @IBOutlet weak var day: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var temperature: UILabel!
    
    func configureCell(with viewModel: WeatherDayViewModel, at index: Int) {
        day.text = viewModel.getDayFor(index: index)
        icon.image = UIImage.imageForIcon(withName: viewModel.image)
        temperature.text = viewModel.temperature
    }
    
}
