//
//  WidgetViewController
//  WeatherWidget
//
//  Created by Adrian Ortiz on 8/15/18.
//  Copyright © 2018 Adrian Ortiz. All rights reserved.
//

import UIKit
import NotificationCenter
import CoreLocation

class WidgetViewController: UIViewController, NCWidgetProviding {
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var summary: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var temMaxMin: UILabel!
    
    // MARK: - Properties
    private let viewModel = MainViewModel(repository: WeatherRepository())
    private var locationManager: LocationManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.didFetchWeather = {[weak self] (success, error) in
            if(success) {
                self?.updateView()
            }
        }
        self.locationManager = LocationManager {[weak self] (newLocation) in
            self?.viewModel.fetchWeatherData(with: newLocation)
        }
    }
    
    private func updateView() {
        icon.image = UIImage.imageForIcon(withName: viewModel.iconTemp)
        summary.text = viewModel.summary
        temperature.text = viewModel.temperature
        temMaxMin.text = viewModel.dayTemp
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        self.locationManager?.requestLocation()
        completionHandler(NCUpdateResult.newData)
    }
    
}
