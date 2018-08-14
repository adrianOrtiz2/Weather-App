//
//  MainViewController.swift
//  Weather
//
//  Created by Adrian Ortiz on 8/14/18.
//  Copyright (c) 2018 Adrian Ortiz. All rights reserved.
//
import UIKit
import CoreLocation

class MainViewController: UIViewController {
    
    @IBOutlet weak var currentlyIcon: UIImageView!
    @IBOutlet weak var currentlyTemp: UILabel!
    @IBOutlet weak var currentlyMin: UILabel!
    @IBOutlet weak var currentlyMax: UILabel!
    @IBOutlet weak var currentlySummary: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    
    private lazy var locationManager: CLLocationManager = {
        // Initialize Location Manager
        let locationManager = CLLocationManager()
        
        // Configure Location Manager
        locationManager.distanceFilter = 1000.0
        locationManager.desiredAccuracy = 1000.0
        
        return locationManager
    }()
    
    var viewModel: MainViewModel! {
        didSet {
            setupViewModel()
        }
    }
    
    private var currentLocation: CLLocation? {
        didSet {
            viewModel.fetchWeatherData(with: currentLocation!)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        notificationsHandler()
    }
    
    // MARK: - Life cycle

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Notifications
    
    @objc func applicationDidBecomeActive(notification: Notification) {
        requestLocation()
    }
    
    private func notificationsHandler() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(applicationDidBecomeActive(notification:)), name: Notification.Name.UIApplicationDidBecomeActive, object: nil)
    }
    
    // MARK: - Request User Location
    private func requestLocation() {
        locationManager.delegate = self
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            locationManager.requestLocation()
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    private func updateView() {
        currentlyTemp.text = viewModel.temperature
        currentlyMin.text = viewModel.minTemp
        currentlyMax.text = viewModel.maxTemp
        currentlySummary.text = viewModel.summary
        currentlyIcon.image = UIImage.imageForIcon(withName: viewModel.iconTemp)
        collectionView.reloadData()
    }
    
    private func setupViewModel() {
        viewModel.didFetchWeather = {[weak self] (success, error) in
            if(success) {
                self?.updateView()
            }
        }
    }
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DayWeatherCell.ReuseIdentifier, for: indexPath) as? DayWeatherCell else {
            fatalError("Missing cell")
        }
        
        guard let dayViewModel = viewModel.dayViewModelFor(index: indexPath.row) else {
            return cell
        }
        
        cell.configureCell(with: dayViewModel, at: indexPath.row)
        return cell
    }
}

extension MainViewController: CLLocationManagerDelegate {
    
    // MARK: - Location Change Authorization
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            manager.requestLocation()
        } else {
            currentLocation = Defaults.location
        }
    }
    
    // MARK: - Location Updates
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            currentLocation = location
            manager.delegate = nil
            manager.stopUpdatingHeading()
        } else { // Failed to get location
            currentLocation = Defaults.location
        }
    }
    
    // MARK: - Location Did Fail
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if currentLocation == nil {
            currentLocation = Defaults.location
        }
    }
    
}
