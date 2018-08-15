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
    
    var viewModel: MainViewModel! {
        didSet {
            setupViewModel()
        }
    }
    private var locationManager: LocationManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        notificationsHandler()
        locationManager = LocationManager(locationResponse: {[weak self] (newLocation) in
            self?.viewModel.fetchWeatherData(with: newLocation)
        })
    }
    
    // MARK: - Life cycle

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Notifications
    
    @objc func applicationDidBecomeActive(notification: Notification) {
        locationManager?.requestLocation()
    }
    
    private func notificationsHandler() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(applicationDidBecomeActive(notification:)), name: UIApplication.didBecomeActiveNotification, object: nil)
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
