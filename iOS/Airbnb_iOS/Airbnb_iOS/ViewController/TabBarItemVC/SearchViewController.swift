//
//  SearchViewController.swift
//  Airbnb_iOS
//
//  Created by juntaek.oh on 2022/05/24.
//

import UIKit
import CoreLocation

class SearchViewController: UIViewController {

    private let browseViewController = BrowseViewController()
    private lazy var homeView = HomeView(frame: view.frame)
    private let dataSource = SearchViewCollectionDataSource()
    
    private let locationManager = CLLocationManager()
    private var currentLocation = CLLocation()

    let searchBar: UISearchBar = {
        let searcher = UISearchBar()
        searcher.placeholder = "어디로 여행가세요?"
        return searcher
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureSettings()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.hidesBarsOnSwipe = true
    }
}

private extension SearchViewController {
    
    func configureSettings() {
        self.addChild(browseViewController)
        self.setHomeView()
        self.setSearchBar()
        self.setLocationAccess()
    }
    
    func setHomeView() {
        self.view = homeView
        self.homeView.setDataSource(dataSource)
    }
    
    func setSearchBar() {
        searchBar.delegate = self
        self.navigationItem.titleView = searchBar
    }
    
    func setLocationAccess() {
        guard CLLocationManager.locationServicesEnabled() else { return }
        
        self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        browseViewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(browseViewController, animated: true)

        return false
    }
}

extension SearchViewController: CLLocationManagerDelegate {
    
    @available(iOS 14, *)
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            manager.startUpdatingLocation()
        case .notDetermined, .restricted:
            manager.requestWhenInUseAuthorization()
        case .denied:
            break
        @unknown default:
            return
        }
        
        switch manager.accuracyAuthorization {
        case .fullAccuracy:
            self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        case .reducedAccuracy:
            self.locationManager.desiredAccuracy = kCLLocationAccuracyReduced
        @unknown default:
            return
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            manager.startUpdatingLocation()
        case .restricted, .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .denied:
            break
        @unknown default:
            return
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        
        self.currentLocation = location
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
}
